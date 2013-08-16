Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:58777 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752973Ab3HPN2L convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 16 Aug 2013 09:28:11 -0400
Message-ID: <1376659687.11176.3.camel@hornet>
Subject: Re: [PATCH/RFC v4 3/3] DT: Add documentation for gp2ap020a00f sensor
From: Pawel Moll <pawel.moll@arm.com>
To: Jacek Anaszewski <j.anaszewski@samsung.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"jic23@kernel.org" <jic23@kernel.org>,
	"kyungmin.park@samsung.com" <kyungmin.park@samsung.com>,
	"s.nawrocki@samsung.com" <s.nawrocki@samsung.com>,
	"rob.herring@calxeda.com" <rob.herring@calxeda.com>,
	Mark Rutland <Mark.Rutland@arm.com>,
	"swarren@wwwdotorg.org" <swarren@wwwdotorg.org>,
	"ian.campbell@citrix.com" <ian.campbell@citrix.com>
Date: Fri, 16 Aug 2013 14:28:07 +0100
In-Reply-To: <1376658760-3459-1-git-send-email-j.anaszewski@samsung.com>
References: <1376658760-3459-1-git-send-email-j.anaszewski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 2013-08-16 at 14:12 +0100, Jacek Anaszewski wrote:
> diff --git a/Documentation/devicetree/bindings/iio/light/gp2ap020a00f.txt b/Documentation/devicetree/bindings/iio/light/gp2ap020a00f.txt
> new file mode 100644
> index 0000000..e4f377d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/light/gp2ap020a00f.txt
> @@ -0,0 +1,20 @@
> +* Sharp GP2AP020A00F I2C Proximity/ALS sensor
> +
> +Required properties:
> +
> +  - compatible : should be "sharp,gp2ap020a00f"
> +  - reg : the I2C address of the light sensor
> +  - interrupt-parent : phandle to the parent interrupt controller
> +  - interrupts : should be INT interrupt pin

Any particular reason for the interrupt-parent being required? Couldn't
it be inherited, as is happens in most cases?

Paweł


