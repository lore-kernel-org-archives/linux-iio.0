Return-Path: <otavio.salvador@gmail.com>
MIME-Version: 1.0
Sender: otavio.salvador@gmail.com
In-Reply-To: <1372886714-25456-1-git-send-email-marex@denx.de>
References: <1372886714-25456-1-git-send-email-marex@denx.de>
Date: Thu, 4 Jul 2013 17:22:11 -0300
Message-ID: <CAP9ODKq2y6Ttm2gQc+LxJZi1hrYh2E8dQRW2_zsi4dd=xzsi1g@mail.gmail.com>
Subject: Re: [PATCH V2] iio: mxs-lradc: Remove useless check in read_raw
From: Otavio Salvador <otavio@ossystems.com.br>
To: Marek Vasut <marex@denx.de>
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	Fabio Estevam <fabio.estevam@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On Wed, Jul 3, 2013 at 6:25 PM, Marek Vasut <marex@denx.de> wrote:
> The removed check in the read_raw implementation was always true,
> therefore remove it. This also fixes a bug, by closely inspecting
> the code, one can notice the iio_validate_scan_mask_onehot() will
> always return 1 and therefore the subsequent condition will always
> succeed, therefore making the mxs_lradc_read_raw() function always
> return -EINVAL; .
>
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Fabio Estevam <fabio.estevam@freescale.com>

Tested-by: Otavio Salvador <otavio@ossystems.com.br>

--
Otavio Salvador                             O.S. Systems
http://www.ossystems.com.br        http://projetos.ossystems.com.br
Mobile: +55 (53) 9981-7854            Mobile: +1 (347) 903-9750
