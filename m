Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:33992 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752082Ab3JINHA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 9 Oct 2013 09:07:00 -0400
From: =?utf-8?q?J=C3=BCrgen_Beisert?= <jbe@pengutronix.de>
To: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] iio: adc: Move mxs-lradc out of staging
Date: Wed, 9 Oct 2013 15:08:30 +0200
Cc: "Lars-Peter Clausen" <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	"Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
	Marek =?utf-8?q?Va=C5=A1ut?= <marex@denx.de>,
	linux-iio@vger.kernel.org,
	Fabio Estevam <fabio.estevam@freescale.com>
References: <1381263410-29849-1-git-send-email-festevam@gmail.com> <5254F9B8.8080205@metafoo.de> <CAOMZO5Cd3JqEWwgNK-kGf4Nq0aNWmvf_X+KR9bM99yVxXRYUQw@mail.gmail.com>
In-Reply-To: <CAOMZO5Cd3JqEWwgNK-kGf4Nq0aNWmvf_X+KR9bM99yVxXRYUQw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <201310091508.30046.jbe@pengutronix.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Fabio,

On Wednesday 09 October 2013 14:31:26 Fabio Estevam wrote:
> On Wed, Oct 9, 2013 at 3:37 AM, Lars-Peter Clausen <lars@metafoo.de> wrote:
> > On 10/08/2013 10:16 PM, Fabio Estevam wrote:
> >> From: Fabio Estevam <fabio.estevam@freescale.com>
> >>
> >> There have been some discussions [1] about removing this driver out of
> >> staging, so let's do it now.
> >>
> >> [1] http://www.spinics.net/lists/linux-iio/msg10091.html
> >
> > What about the TODO[1] entry that was recently added?
>
> Good catch.
>
> Would it be acceptable if I move the mxs TODO text into mxs-lradc.c?

Sounds like you want to make it forgotten. ;)

Regards,
Juergen

-- 
Pengutronix e.K.                              | Juergen Beisert             |
Linux Solutions for Science and Industry      | http://www.pengutronix.de/  |
