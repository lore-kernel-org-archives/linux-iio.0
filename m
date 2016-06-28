Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qk0-f194.google.com ([209.85.220.194]:35923 "EHLO
	mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752799AbcF1VGb (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 28 Jun 2016 17:06:31 -0400
Date: Tue, 28 Jun 2016 16:06:22 -0500
From: Rob Herring <robh@kernel.org>
To: Raveendra Padasalagi <raveendra.padasalagi@broadcom.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
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
Subject: Re: [PATCH v4 1/3] Documentation: DT: Add iproc-static-adc binding
Message-ID: <20160628210622.GA10297@rob-hp-laptop>
References: <1467099636-31855-1-git-send-email-raveendra.padasalagi@broadcom.com>
 <1467099636-31855-2-git-send-email-raveendra.padasalagi@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1467099636-31855-2-git-send-email-raveendra.padasalagi@broadcom.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, Jun 28, 2016 at 01:10:34PM +0530, Raveendra Padasalagi wrote:
> The patch adds devicetree binding document for broadcom's
> iproc-static-adc controller driver.
> 
> Signed-off-by: Raveendra Padasalagi <raveendra.padasalagi@broadcom.com>
> Reviewed-by: Ray Jui <ray.jui@broadcom.com>
> Reviewed-by: Scott Branden <scott.branden@broadcom.com>
> ---
>  .../bindings/iio/adc/brcm,iproc-static-adc.txt     | 41 ++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/brcm,iproc-static-adc.txt

Acked-by: Rob Herring <robh@kernel.org>
