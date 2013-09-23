Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:44546 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752706Ab3IWP0B (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 23 Sep 2013 11:26:01 -0400
From: Marek Vasut <marex@denx.de>
To: Juergen Beisert <jbe@pengutronix.de>
Subject: Re: [PATCHv6] staging/iio/adc: change the MXS touchscreen driver implementation
Date: Mon, 23 Sep 2013 17:25:58 +0200
Cc: linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devel@driverdev.osuosl.org, fabio.estevam@freescale.com,
	jic23@cam.ac.uk, linux-input@vger.kernel.org
References: <1379946998-23041-1-git-send-email-jbe@pengutronix.de>
In-Reply-To: <1379946998-23041-1-git-send-email-jbe@pengutronix.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201309231725.58996.marex@denx.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Dear Juergen Beisert,

> The following series replaces the current busy loop touchscreen
> implementation for i.MX28/i.MX23 SoCs by a fully interrupt driven
> implementation.
> 
> Since i.MX23 and i.MX28 silicon differs, the existing implementation can
> be used for the i.MX28 SoC only.
> 
> The first patch adds proper clock handling. Various platforms seems to
> disable the internal 2 kHz clock which is used by the LRADC delay units.
> 
> The next two patches of this series move the i.MX28 specific definitions
> out of the way. The forth patch simplifies the register access to make it
> easier to add the i.MX23 support. Then the i.MX23 specific definitions are
> added, also the code to distinguish both SoCs at run-time.
> Up to here the existing touchscreen driver will now run on an i.MX23 Soc as
> well.
> 
> When these i.MX SoCs are running from battery it seems not to be a good
> idea to run a busy loop to detect touches and their location. The 6th
> patch adds a fully interrupt driven implementation which makes use of the
> built-in delay and multiple sample features of the touchscreen controller.
> This will reduce the interrupt load to a minimum.
> 
> The remaining patches in this series just removes the existing busy loop
> implementation, add a proposal for devicetree binding and a reminder what
> has still to be done with the LRADC driver.
> 
> Changes since v5:
> 
> - add missing clock handling which prevents the delay units from work (this
>   should make it work on the MX28EVK and M28EVK as well)
> 
> Changes since v4:
> 
> - honor Jonathan's comments about function names
> - honor Dmitry's comments about workqueue canceling and interrupts
> - adding devicetree bindings proposal
> 
> Changes since v3:
> 
> - split adding register access functions and i.MX23 support into two
> patches
> 
> Changes since v2:
> 
> - useless debug output removed
> 
> Changes since v1:
> 
> - adding register access functions to make the existing code more readable
> - adding some functions to distinguish the SoCs at run-time to avoid
> if-else contructs whenever differences in the register layout between
> i.MX23 and i.MX28 must be handled
> 
> Comments are welcome.

On M28EVK:

Tested-by: Marek Vasut <marex@denx.de>
Acked-by: Marek Vasut <marex@denx.de>

Thanks!

Best regards,
Marek Vasut
