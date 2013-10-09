Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:40685 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751769Ab3JIOMa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 9 Oct 2013 10:12:30 -0400
From: =?utf-8?q?J=C3=BCrgen_Beisert?= <jbe@pengutronix.de>
To: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] iio: adc: Move mxs-lradc out of staging
Date: Wed, 9 Oct 2013 16:14:00 +0200
Cc: "Lars-Peter Clausen" <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	"Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
	Marek =?utf-8?q?Va=C5=A1ut?= <marex@denx.de>,
	linux-iio@vger.kernel.org,
	Fabio Estevam <fabio.estevam@freescale.com>
References: <1381263410-29849-1-git-send-email-festevam@gmail.com> <201310091508.30046.jbe@pengutronix.de> <CAOMZO5AmncWZdtJjN54+PA9KBAnRf_-h8Tp=34hEckQo-S_gaw@mail.gmail.com>
In-Reply-To: <CAOMZO5AmncWZdtJjN54+PA9KBAnRf_-h8Tp=34hEckQo-S_gaw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <201310091614.00683.jbe@pengutronix.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Fabio,

On Wednesday 09 October 2013 15:17:33 Fabio Estevam wrote:
> On Wed, Oct 9, 2013 at 10:08 AM, Jürgen Beisert <jbe@pengutronix.de> wrote:
> >> Would it be acceptable if I move the mxs TODO text into mxs-lradc.c?
> >
> > Sounds like you want to make it forgotten. ;)
>
> What would you suggest?

Keep the driver in staging until somebody can spend some effort to split this 
driver into an MFD and at least into its IIO (generic ADC) and touchscreen 
components. IMHO the touchscreen component should go into the input subsystem 
part of the kernel tree, its not related to IIO.

Regards,
Juergen

-- 
Pengutronix e.K.                              | Juergen Beisert             |
Linux Solutions for Science and Industry      | http://www.pengutronix.de/  |
