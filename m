Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:52108 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751587Ab3JAIZW (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 1 Oct 2013 04:25:22 -0400
Message-ID: <524A951A.5050606@kernel.org>
Date: Tue, 01 Oct 2013 10:25:46 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Juergen Beisert <jbe@pengutronix.de>, linux-iio@vger.kernel.org
CC: linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org,
	marex@denx.de, fabio.estevam@freescale.com, jic23@cam.ac.uk,
	linux-input@vger.kernel.org
Subject: Re: [PATCHv6] staging/iio/adc: change the MXS touchscreen driver
 implementation
References: <1379946998-23041-1-git-send-email-jbe@pengutronix.de>
In-Reply-To: <1379946998-23041-1-git-send-email-jbe@pengutronix.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

I'm looking for some Tested-by: or Acks on this before applying the series.
I got the impression from the comments on the previous version that the
series has now been reasonably thoroughly tested on both i.MX28 and i.MX23 boards.
This is not yet reflected in the sign off trail and in fact a couple of the patch
descriptions say that they are untested on i.MX28.

Jonathan


On 09/23/13 15:36, Juergen Beisert wrote:
> The following series replaces the current busy loop touchscreen implementation
> for i.MX28/i.MX23 SoCs by a fully interrupt driven implementation.
> 
> Since i.MX23 and i.MX28 silicon differs, the existing implementation can
> be used for the i.MX28 SoC only.
> 
> The first patch adds proper clock handling. Various platforms seems to disable
> the internal 2 kHz clock which is used by the LRADC delay units.
> 
> The next two patches of this series move the i.MX28 specific definitions
> out of the way. The forth patch simplifies the register access to make it easier
> to add the i.MX23 support. Then the i.MX23 specific definitions are added, also
> the code to distinguish both SoCs at run-time.
> Up to here the existing touchscreen driver will now run on an i.MX23 Soc as well.
> 
> When these i.MX SoCs are running from battery it seems not to be a good idea to
> run a busy loop to detect touches and their location. The 6th patch adds a
> fully interrupt driven implementation which makes use of the built-in delay
> and multiple sample features of the touchscreen controller. This will reduce
> the interrupt load to a minimum.
> 
> The remaining patches in this series just removes the existing busy loop
> implementation, add a proposal for devicetree binding and a reminder what has
> still to be done with the LRADC driver.
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
> - split adding register access functions and i.MX23 support into two patches
> 
> Changes since v2:
> 
> - useless debug output removed
> 
> Changes since v1:
> 
> - adding register access functions to make the existing code more readable
> - adding some functions to distinguish the SoCs at run-time to avoid if-else
>   contructs whenever differences in the register layout between i.MX23 and
>   i.MX28 must be handled
> 
> Comments are welcome.
> 
> Juergen
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
