Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794213747;
	b=t4Dy3mnByC8txEbvFAOTGIf43pH6TfGDRQfP9Kez1H26h0yz51zblIeQDSwzH5PTH/Qv
	 bWJRkVqPY92v88k/FBYO7HQj/besoeiZ/1Y99Ejyhbir3xX9uANALn474BEQZshgDHGjH
	 MGQ/Xkm3TNgXa7HXqM0ZSOk0h6S3JEfJx01UaShfoZA8bsmxqxQ0Q8eAmiAqRfBqpTAMj
	 TJnNnjvpvjZFVHQn/snWSTF2PUaeYMNFUiB9PDTJDOpCjIuilSIrgpCrlxsEzCBtyYRDZ
	 IL/mrsLK27t/AjYCeE+LvWbRK3KOEjJGguaJ3lSaFWA14N7YROB6eBwZaIjWxKIom/w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794213747;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=xq2W+DbzQKP7CTPJr7r8Z25kcdz5jvMXAXDiLOlCpBo=;
	b=RNbtVNs/IHUb60IUBxtemC7OuhSn1+1qGiPy91wc4kG1MM2i/eybPXaKO+1pOyXucGmL
	 kG9M3IgX6Oq2Zy3V60TuoLGYXrUbrqed8Uam6diP224hIlikugdls5yaU/WZ3DIBA3ndz
	 glGaASYPMjTH3K3avGaS6YEbnFjVlBRa2NqOc0PF2Ezu0gdKqCRlVvHBz4dv0Ji/FuIi8
	 W0G5ejF1DqCSilI0p2iksH446ZjOai4Gq2RErBisL8DrGaLefi3HMKvOT2tpmxg/hZYpM
	 jlTG/QvZzHRc02V8ncRHY0OpWluRO45N8ImmcyJziB5lv2hABd04TC4jMTgkofqyj9A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PjQGX5ik;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50102606A326;
	Mon,  9 Nov 2026 08:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PjQGX5ik
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=90.182.112.124
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794213746;
	b=3jl7BgMEglT1/ybJ6z8QI7dCnppBnk8/CnN+2qdu0qSiChSXFgr8zzK5tFdoE3OtS5Sw
	 qzG81ABpM62GUomdY3lYHYyL4BK2VE9Ekt/NkJsJmg/jI0c4MsNlAP/zuHT939iPCgrTA
	 3o6GRf5iz9aJ7p3ihIlC4Qw4DneUYs9NJF43gVeUKaoFlbqrQ0Se10nW1+H29W3HSQK6c
	 qf0Bze9qlF0MFapJvss5wxrDEk0IfYsdNbrlRyW1l26Ru1+tJpauGXxyJ1kE/2pvpV8SM
	 S046csFAHBh5PbHF20smmlRjUdoZ16pTbfX9muALB74PfLe3WwNO0UWHuP9MvuIn5JA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794213746;
	h=DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=xq2W+DbzQKP7CTPJr7r8Z25kcdz5jvMXAXDiLOlCpBo=;
	b=nfrKoRN91E//wEdojkR8umosiitGlg7T3XV7itKf1noGR+vyLdvReo1ryhpb8Rw+eQSg
	 gOYtgEROYrzOnMK3Py/Be8bWMPWAOEZMagKJwyRp8k+MEz7N1oRZDhQk2jKTBvbdpSZ6R
	 JfkYbba89y5TdsLvXmnRWs010N3s1sHQC95FWYLk78gJiqRanDJbOzhBv36aQrsuDQehz
	 pW83k1TAHulJVlxYACM1qOG0IBGHTqGPAkzaBC9Uqo3cL+VVE/PhjhLKckrA7DDzpm4fY
	 NFgjOOxY/hmM+ryv1EPwAX7w8VNSa4Y3nVwJlFaVlh6vC7g9Iv664yPOmG53/3eXAIw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=90.182.112.124
Received: from localhost (90-182-112-124.rcp.o2.cz [90.182.112.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPSA id 315541F008A1;
	Mon,  9 Nov 2026 08:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794213746;
	bh=xq2W+DbzQKP7CTPJr7r8Z25kcdz5jvMXAXDiLOlCpBo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=PjQGX5ikj18ixU1M1yk44tzTbySRzSCyrLcHVmojCQnbEGbaXhtDMSZJBSB2ZHDyv
	 1+ldfZHSoDz619h3s7tUdPAZ5MjHjqqc9lzlAcKbp/+nGR+lG55mwNCrVKWsuoLyoO
	 +EtR6+V8YfoCbeCRDxm4unLNtvOoEHdQnO7LqFGESZHzZkKDLx1mpZN6Y3rJFxo8rS
	 04AVtFK4j/FJyAh/x99yNDKBZ3fLOFxPIYx7vhVj5hIAN1uWULHBSUzMe+jIvoDq85
	 Uwgson9yMyo2d+0vbqkl3+RC7j+J+Gz6rQmQ/d2dgoMvrqi+fvMEtC3T+aF9tVPmGS
	 WRC2AN9WC2EOQ==
Date: Mon, 9 Nov 2026 09:42:02 +0100
From: Joshua Crofts <crofts@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Miquel Raynal <miquel.raynal@bootlin.com>,
 Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Song Qiang <songqiang1304521@gmail.com>, Radu Sabau
 <radu.sabau@analog.com>, Maxwell Doose <maxwell@maxwelld.cc>, Tomasz
 Duszynski <tduszyns@gmail.com>, Erikas Bitovtas <xerikasxx@gmail.com>,
 Waqar Hameed <waqar.hameed@axis.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-kernel@vger.kernel.org, Jonathan
 Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: Re: [RESEND PATCH 11/14] iio: proximity: vl53l1x-i2c: poll own
 trigger from interrupt handler
Message-ID: <20261109094202.0000284f@kernel.org>
In-Reply-To: <20261109042851.1326940-12-jic23@kernel.org>
References: <20261109042851.1326940-1-jic23@kernel.org>
	<20261109042851.1326940-12-jic23@kernel.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  9 Nov 2026 04:28:48 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> 
> Keep a pointer to the driver's trigger in struct vl53l1x_data and poll
> that from vl53l1x_irq_handler() rather than indio_dev->trig. Only the
> driver's own trigger is accepted, via iio_validate_own_trigger(), so
> with the buffer enabled that is the trigger in use.
> 
> This removes a dependency on the trig field of struct iio_dev, which
> is to become private to the IIO core.
> 
> Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> ---
>  drivers/iio/proximity/vl53l1x-i2c.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/proximity/vl53l1x-i2c.c b/drivers/iio/proximity/vl53l1x-i2c.c
> index bce238d1b6de..ffc6fe45b165 100644
> --- a/drivers/iio/proximity/vl53l1x-i2c.c
> +++ b/drivers/iio/proximity/vl53l1x-i2c.c
> @@ -102,6 +102,7 @@ struct vl53l1x_data {
>  	enum vl53l1x_distance_mode distance_mode;
>  	u8 gpio_polarity;
>  	int irq;
> +	struct iio_trigger *trig;

Pahole reports a 4 byte hole between irq and trig. Reordering
like this yields a better result:

struct regmap *            regmap;               /*     0     8 */
struct completion          completion __attribute__((__aligned__(8))); /*     8    32 */

/* XXX last struct has 1 hole */

struct reset_control *     xshut_reset;          /*    40     8 */
struct iio_trigger *       trig;                 /*    48     8 */
enum vl53l1x_distance_mode distance_mode;        /*    56     4 */
int                        irq;                  /*    60     4 */
/* --- cacheline 1 boundary (64 bytes) --- */
u8                         gpio_polarity;        /*    64     1 */

-- 
Kind regards,
Joshua Crofts
