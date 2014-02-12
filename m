Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:43535 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751105AbaBLMVr (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 12 Feb 2014 07:21:47 -0500
Date: Wed, 12 Feb 2014 12:21:37 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Paul Cercueil <paul.cercueil@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"rob.herring@calxeda.com" <rob.herring@calxeda.com>,
	Pawel Moll <Pawel.Moll@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Rob Landley <rob@landley.net>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH] devicetree: ad7303: Updated documentation
Message-ID: <20140212122137.GA25957@e106331-lin.cambridge.arm.com>
References: <1392206903-1662-1-git-send-email-paul.cercueil@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1392206903-1662-1-git-send-email-paul.cercueil@analog.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Feb 12, 2014 at 12:08:23PM +0000, Paul Cercueil wrote:
> Added documentation about the "adi,use-external-reference"
> property.
> 
> Signed-off-by: Paul Cercueil <paul.cercueil@analog.com>
> ---
>  Documentation/devicetree/bindings/iio/dac/ad7303.txt |    3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/dac/ad7303.txt b/Documentation/devicetree/bindings/iio/dac/ad7303.txt
> index 914610f..de6b32f 100644
> --- a/Documentation/devicetree/bindings/iio/dac/ad7303.txt
> +++ b/Documentation/devicetree/bindings/iio/dac/ad7303.txt
> @@ -7,6 +7,9 @@ Required properties:
>  	- Vdd-supply: Phandle to the Vdd power supply
>  
>  Optional properties:
> +	- adi,use-external-reference: If set, the external reference voltage
> +	  supply is used. Otherwise, the internal reference voltage supply is
> +	  used.

As I asked for the ad5064 binding document, when would you want to do
this, and why can't the driver decide?

Cheers,
Mark.
