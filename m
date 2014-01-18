Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:37829 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751830AbaARLML (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 18 Jan 2014 06:12:11 -0500
Message-ID: <52DA6199.3020706@kernel.org>
Date: Sat, 18 Jan 2014 11:12:25 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 6/6] staging:iio:accel:sca3000: Cleanup sca3000.h
References: <1389648514-31429-1-git-send-email-pmeerw@pmeerw.net> <1389648514-31429-5-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1389648514-31429-5-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 13/01/14 21:28, Peter Meerwald wrote:
> kerneldoc and comment formating, typos
>
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Applied to the togreg branch of iio.git.

Thanks for cleaning this up. I've been feeling a bit guilty about the state
of this driver for some time but never quite gotten round to fixing it!

Jonathan
> ---
>   drivers/staging/iio/accel/sca3000.h | 26 ++++++++++++++++----------
>   1 file changed, 16 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/staging/iio/accel/sca3000.h b/drivers/staging/iio/accel/sca3000.h
> index c1016c5..b284e5a 100644
> --- a/drivers/staging/iio/accel/sca3000.h
> +++ b/drivers/staging/iio/accel/sca3000.h
> @@ -65,7 +65,8 @@
>
>   #define SCA3000_RING_BUF_ENABLE			0x80
>   #define SCA3000_RING_BUF_8BIT			0x40
> -/* Free fall detection triggers an interrupt if the acceleration
> +/*
> + * Free fall detection triggers an interrupt if the acceleration
>    * is below a threshold for equivalent of 25cm drop
>    */
>   #define SCA3000_FREE_FALL_DETECT		0x10
> @@ -73,8 +74,9 @@
>   #define SCA3000_MEAS_MODE_OP_1			0x01
>   #define SCA3000_MEAS_MODE_OP_2			0x02
>
> -/* In motion detection mode the accelerations are band pass filtered
> - * (aprox 1 - 25Hz) and then a programmable threshold used to trigger
> +/*
> + * In motion detection mode the accelerations are band pass filtered
> + * (approx 1 - 25Hz) and then a programmable threshold used to trigger
>    * and interrupt.
>    */
>   #define SCA3000_MEAS_MODE_MOT_DET		0x03
> @@ -99,8 +101,10 @@
>   #define SCA3000_REG_CTRL_SEL_MD_Y_TH		0x03
>   #define SCA3000_REG_CTRL_SEL_MD_X_TH		0x04
>   #define SCA3000_REG_CTRL_SEL_MD_Z_TH		0x05
> -/* BE VERY CAREFUL WITH THIS, IF 3 BITS ARE NOT SET the device
> -   will not function */
> +/*
> + * BE VERY CAREFUL WITH THIS, IF 3 BITS ARE NOT SET the device
> + * will not function
> + */
>   #define SCA3000_REG_CTRL_SEL_OUT_CTRL		0x0B
>   #define SCA3000_OUT_CTRL_PROT_MASK		0xE0
>   #define SCA3000_OUT_CTRL_BUF_X_EN		0x10
> @@ -109,8 +113,9 @@
>   #define SCA3000_OUT_CTRL_BUF_DIV_4		0x02
>   #define SCA3000_OUT_CTRL_BUF_DIV_2		0x01
>
> -/* Control which motion detector interrupts are on.
> - * For now only OR combinations are supported.x
> +/*
> + * Control which motion detector interrupts are on.
> + * For now only OR combinations are supported.
>    */
>   #define SCA3000_MD_CTRL_PROT_MASK		0xC0
>   #define SCA3000_MD_CTRL_OR_Y			0x01
> @@ -121,7 +126,8 @@
>   #define SCA3000_MD_CTRL_AND_X			0x10
>   #define SAC3000_MD_CTRL_AND_Z			0x20
>
> -/* Some control registers of complex access methods requiring this register to
> +/*
> + * Some control registers of complex access methods requiring this register to
>    * be used to remove a lock.
>    */
>   #define SCA3000_REG_ADDR_UNLOCK			0x1e
> @@ -139,7 +145,8 @@
>   /* Values of multiplexed registers (write to ctrl_data after select) */
>   #define SCA3000_REG_ADDR_CTRL_DATA		0x22
>
> -/* Measurement modes available on some sca3000 series chips. Code assumes others
> +/*
> + * Measurement modes available on some sca3000 series chips. Code assumes others
>    * may become available in the future.
>    *
>    * Bypass - Bypass the low-pass filter in the signal channel so as to increase
> @@ -160,7 +167,6 @@
>    * struct sca3000_state - device instance state information
>    * @us:			the associated spi device
>    * @info:			chip variant information
> - * @indio_dev:			device information used by the IIO core
>    * @interrupt_handler_ws:	event interrupt handler for all events
>    * @last_timestamp:		the timestamp of the last event
>    * @mo_det_use_count:		reference counter for the motion detection unit
>
