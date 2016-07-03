Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:57404 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751854AbcGCKd3 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 3 Jul 2016 06:33:29 -0400
Subject: Re: [PATCH v4 1/3] Documentation: DT: Add iproc-static-adc binding
To: Rob Herring <robh@kernel.org>,
	Raveendra Padasalagi <raveendra.padasalagi@broadcom.com>
References: <1467099636-31855-1-git-send-email-raveendra.padasalagi@broadcom.com>
 <1467099636-31855-2-git-send-email-raveendra.padasalagi@broadcom.com>
 <20160628210622.GA10297@rob-hp-laptop>
Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Russell King <linux@arm.linux.org.uk>,
	Arnd Bergmann <arnd@arndb.de>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Jonathan Richardson <jonathar@broadcom.com>,
	Jon Mason <jonmason@broadcom.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Anup Patel <anup.patel@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Pramod Kumar <pramod.kumar@broadcom.com>,
	linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <4c40177d-3501-5db9-b0e6-ba78354ab831@kernel.org>
Date: Sun, 3 Jul 2016 11:33:25 +0100
MIME-Version: 1.0
In-Reply-To: <20160628210622.GA10297@rob-hp-laptop>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 28/06/16 22:06, Rob Herring wrote:
> On Tue, Jun 28, 2016 at 01:10:34PM +0530, Raveendra Padasalagi wrote:
>> The patch adds devicetree binding document for broadcom's
>> iproc-static-adc controller driver.
>>
>> Signed-off-by: Raveendra Padasalagi <raveendra.padasalagi@broadcom.com>
>> Reviewed-by: Ray Jui <ray.jui@broadcom.com>
>> Reviewed-by: Scott Branden <scott.branden@broadcom.com>
>> ---
>>  .../bindings/iio/adc/brcm,iproc-static-adc.txt     | 41 ++++++++++++++++++++++
>>  1 file changed, 41 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/iio/adc/brcm,iproc-static-adc.txt
> 
> Acked-by: Rob Herring <robh@kernel.org>
Thanks Rob for your review (sometimes I think I don't express often enough
how helpful device tree binding reviews are in general!)

Applied to the togreg branch of iio.git - initially pushed out as testing for
the autobuilders to ignore it completely ;)

Jonathan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

