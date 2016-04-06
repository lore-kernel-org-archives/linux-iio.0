Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ig0-f193.google.com ([209.85.213.193]:33456 "EHLO
	mail-ig0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751601AbcDFHfv (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 6 Apr 2016 03:35:51 -0400
MIME-Version: 1.0
In-Reply-To: <acaeee6c3c1f99900614baf99ab31e6e5b515970.1459918214.git.amsfield22@gmail.com>
References: <cover.1459918214.git.amsfield22@gmail.com>
	<acaeee6c3c1f99900614baf99ab31e6e5b515970.1459918214.git.amsfield22@gmail.com>
Date: Wed, 6 Apr 2016 09:35:49 +0200
Message-ID: <CAGhQ9VxnwX6n6PfOFAhYSPfP7eAA+YFLjTcJf+Ay60R8sHV_Ww@mail.gmail.com>
Subject: Re: [PATCH 5/9] iio: accel: mma7455: use regmap to retrieve struct device
From: Joachim Eastwood <manabian@gmail.com>
To: Alison Schofield <amsfield22@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Kukjin Kim <kgene@kernel.org>,
	=?UTF-8?Q?Krzysztof_Koz=C5=82owski?= <k.kozlowski@samsung.com>,
	linux-iio@vger.kernel.org,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	linux-samsung-soc@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Alison,

On 6 April 2016 at 07:18, Alison Schofield <amsfield22@gmail.com> wrote:
> Driver includes struct regmap and struct device in its global data.
> Remove the struct device and use regmap API to retrieve device info.
>
> Patch created using Coccinelle plus manual edits.
>
> Signed-off-by: Alison Schofield <amsfield22@gmail.com>
> ---
>  drivers/iio/accel/mma7455_core.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/iio/accel/mma7455_core.c b/drivers/iio/accel/mma7455_core.c
> index c633cc2..c902f54 100644
> --- a/drivers/iio/accel/mma7455_core.c
> +++ b/drivers/iio/accel/mma7455_core.c
> @@ -55,11 +55,11 @@
>
>  struct mma7455_data {
>         struct regmap *regmap;
> -       struct device *dev;
>  };
>
>  static int mma7455_drdy(struct mma7455_data *mma7455)
>  {
> +       struct device *dev = regmap_get_device(mma7455->regmap);

ah, nice!

Acked-by: Joachim Eastwood <manabian@gmail.com>


regards,
Joachim Eastwood
