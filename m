Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48303 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752593AbbADLOl (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 4 Jan 2015 06:14:41 -0500
Message-ID: <54A9209E.2080707@kernel.org>
Date: Sun, 04 Jan 2015 11:14:38 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Stefan Wahren <stefan.wahren@i2se.com>
CC: festevam@gmail.com, kristina.martsenko@gmail.com, knaack.h@gmx.de,
	marex@denx.de, kernel@pengutronix.de, pawel.moll@arm.com,
	ijc+devicetree@hellion.org.uk, robh+dt@kernel.org,
	galak@codeaurora.org, mark.rutland@arm.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH V2 1/2] DT: mxs-lradc: fix ranges of ts properties
References: <1419848841-12749-1-git-send-email-stefan.wahren@i2se.com> <1419848841-12749-2-git-send-email-stefan.wahren@i2se.com>
In-Reply-To: <1419848841-12749-2-git-send-email-stefan.wahren@i2se.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 29/12/14 10:27, Stefan Wahren wrote:
> This patch fixes off-by-one issues in the devicetree binding of
> mxs-lradc.
> 
> According to the i.MX23 and i.MX28 reference manuals [1][2] the range of
> NUM_SAMPLES is 0..31, but property ave-ctrl is substracted by 1 before used.
> 
> Considering all limitations the range of DELAY is 1..2047, but also
> property ave-delay is substracted by 1 before used.
> 
> The patch has been suggested by Hartmut Knaack and Kristina Martsenko.
> 
> [1] - http://cache.freescale.com/files/dsp/doc/ref_manual/IMX23RM.pdf
> [2] - http://cache.freescale.com/files/dsp/doc/ref_manual/MCIMX28RM.pdf
> 
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Hmm.  I debated whether to take these through the fixes tree.  Whilst they
are technically fixing the driver, it is only a fashion that makes it a little
more flexible and the devicetree binding more resilient.  Good stuff, but
can probably wait a cycle.

Anyhow, as such - applied to the togreg branch of iio.git.
Initially pushed out as testing for the autobuilders to play.

Thanks,

Jonathan
> ---
>  .../bindings/staging/iio/adc/mxs-lradc.txt         |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/staging/iio/adc/mxs-lradc.txt b/Documentation/devicetree/bindings/staging/iio/adc/mxs-lradc.txt
> index ee05dc3..3075377 100644
> --- a/Documentation/devicetree/bindings/staging/iio/adc/mxs-lradc.txt
> +++ b/Documentation/devicetree/bindings/staging/iio/adc/mxs-lradc.txt
> @@ -12,9 +12,9 @@ Optional properties:
>                                 property is not present, then the touchscreen is
>                                 disabled. 5 wires is valid for i.MX28 SoC only.
>  - fsl,ave-ctrl: number of samples per direction to calculate an average value.
> -                Allowed value is 1 ... 31, default is 4
> +                Allowed value is 1 ... 32, default is 4
>  - fsl,ave-delay: delay between consecutive samples. Allowed value is
> -                 1 ... 2047. It is used if 'fsl,ave-ctrl' > 1, counts at
> +                 2 ... 2048. It is used if 'fsl,ave-ctrl' > 1, counts at
>                   2 kHz and its default is 2 (= 1 ms)
>  - fsl,settling: delay between plate switch to next sample. Allowed value is
>                  1 ... 2047. It counts at 2 kHz and its default is
> 

