Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:54986 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755467AbaDTPwO (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 20 Apr 2014 11:52:14 -0400
Date: Sun, 20 Apr 2014 17:52:13 +0200
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
Subject: Re: [PATCHv2 2/9] mfd: twl4030-madc: Add DT support and convert to
 IIO framework
Message-ID: <20140420155213.GB16649@amd.pavel.ucw.cz>
References: <1393702365-26429-1-git-send-email-sre@debian.org>
 <1393970751-18157-1-git-send-email-sre@debian.org>
 <1393970751-18157-3-git-send-email-sre@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1393970751-18157-3-git-send-email-sre@debian.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue 2014-03-04 23:05:44, Sebastian Reichel wrote:
> This converts twl4030-madc module to use the Industrial IO ADC
> framework and adds device tree support.
> 
> Signed-off-by: Sebastian Reichel <sre@debian.org>

Reviewed-by: Pavel Machek <pavel@ucw.cz>

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
