Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:55021 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755364AbaDTPyH (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 20 Apr 2014 11:54:07 -0400
Date: Sun, 20 Apr 2014 17:54:05 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Sebastian Reichel <sre@debian.org>
Cc: Sebastian Reichel <sre@ring0.de>,
	Marek Belisko <marek@goldelico.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lee Jones <lee.jones@linaro.org>,
	Samuel Ortiz <sameo@linux.intel.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Grant Likely <grant.likely@linaro.org>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCHv2 3/9] mfd: twl4030-madc: Cleanup driver
Message-ID: <20140420155405.GC16649@amd.pavel.ucw.cz>
References: <1393702365-26429-1-git-send-email-sre@debian.org>
 <1393970751-18157-1-git-send-email-sre@debian.org>
 <1393970751-18157-4-git-send-email-sre@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1393970751-18157-4-git-send-email-sre@debian.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi!

> Some style fixes in twl4030-madc driver.
> 
> Reported-by: Jonathan Cameron <jic23@kernel.org>
> Signed-off-by: Sebastian Reichel <sre@debian.org>
> Acked-by: Lee Jones <lee.jones@linaro.org>

Reviewed-by: Pavel Machek <pavel@ucw.cz>


> @@ -665,10 +660,6 @@ out:
>  }
>  EXPORT_SYMBOL_GPL(twl4030_madc_conversion);
>  
> -/*
> - * Return channel value
> - * Or < 0 on failure.
> - */
>  int twl4030_get_madc_conversion(int channel_no)
>  {
>  	struct twl4030_madc_request req;

Maybe I'd put the comment on one line, but it seems useful...?

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
