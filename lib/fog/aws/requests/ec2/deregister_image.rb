module Fog
  module AWS
    module EC2
      class Real

        require 'fog/aws/parsers/ec2/deregister_image'

        # deregister an image
        #
        # ==== Parameters
        # * image_id<~String> - Id of image to deregister 
        #
        # ==== Returns
        # * response<~Excon::Response>:
        #   * body<~Hash>:
        #     * 'return'<~Boolean> - Returns true if deregistration succeeded
        #     * 'requestId'<~String> - Id of request
        def deregister_image(image_id)
          request(
            'Action'      => 'DeregisterImage',
            'ImageId'     => image_id,
            :parser       => Fog::Parsers::AWS::EC2::DeregisterImage.new
          )
        end

      end

      class Mock

        def deregister_image(image_id)
          response = Excon::Response.new
          if image_id 
            response.status = 200
            response.body = {
              'requestId' => Fog::AWS::Mock.request_id,
              'return' => "true"
            }
            response
          else
            message = 'MissingParameter => '
            if !instance_id
              message << 'The request must contain the parameter image_id'
            end
            raise Fog::AWS::EC2::Error.new(message)
          end
        end

      end
    end
  end
end
