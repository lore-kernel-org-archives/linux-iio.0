Received: from aposti.net (aposti.net [185.119.170.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6547A54654;
	Thu, 16 Apr 2026 10:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.119.170.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776334522; cv=none; b=Wv7k+OwxY3GNRT6xsxFzDeHCYAItPOdfEomopvyz+Hr6zzLC2OfFzlKzYRxz6xBsJfo7kBj9CcHOdZop4TPk1i59ADdQIY1qSDXO9CUT2gMRQwTcjIadsZ6Yoj3Z81eGpKv80MI/tnx7912WZeN143xmXkcPl9afiR56cVNgBEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776334522; c=relaxed/simple;
	bh=6+vCQ8HoSEy1R07WjiNOuOnlpOqYtNKsO1+XSB2RpK0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GLZ9jPSQBMRZayaZFAZAHkjx7mhAJuXTukDuI8ovolb+FKXJHESVX4ZU5d4DFY9yg3+FBYjjRJ01hfStFY5gOLvGNIMiHHphXYjl+9rTdnqQtFL/azzrtoTDQq7RS72rGPDFF/iNClhVvjOxTrzLaDIGGzj7cxiJqw6ZM1GHdvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crapouillou.net; spf=pass smtp.mailfrom=crapouillou.net; dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b=UqkpgA+D; arc=none smtp.client-ip=185.119.170.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crapouillou.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crapouillou.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="UqkpgA+D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crapouillou.net;
	s=mail; t=1776334136;
	bh=6+vCQ8HoSEy1R07WjiNOuOnlpOqYtNKsO1+XSB2RpK0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=UqkpgA+DMIo1TZXaqJN4J42EsA54KYEKIpBsFFOU0GFwsqT7Xg0FyXPzTuZy+BKNB
	 P2GtTkBpXv29YYegmzae7IPi2ur+0wZKdLTX6dXRVshhwJyj8Nx00klgZ9Q1jsAw2W
	 I1B0kGGAJE16v4iaFzYzVt1JOw1+vKtRdUdpogQ0=
Message-ID: <2412f5b041f89557c238164065e7f8d704579c58.camel@crapouillou.net>
Subject: Re: [PATCH] iio: adc: ingenic-adc: use guard(mutex)(&lock) to
 handle synchronisation
From: Paul Cercueil <paul@crapouillou.net>
To: Felipe Ribeiro de Souza <felipers@ime.usp.br>, jic23@kernel.org, 
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org
Cc: Lucas Ivars Cadima Ciziks <lucas@ciziks.com>,
 linux-mips@vger.kernel.org, 	linux-iio@vger.kernel.org
Date: Thu, 16 Apr 2026 12:08:52 +0200
In-Reply-To: <20260416011815.9140-1-felipers@ime.usp.br>
References: <20260416011815.9140-1-felipers@ime.usp.br>
Autocrypt: addr=paul@crapouillou.net; prefer-encrypt=mutual;
 keydata=mQENBF0KhcEBCADkfmrzdTOp/gFOMQX0QwKE2WgeCJiHPWkpEuPH81/HB2dpjPZNW03ZM
 LQfECbbaEkdbN4YnPfXgcc1uBe5mwOAPV1MBlaZcEt4M67iYQwSNrP7maPS3IaQJ18ES8JJ5Uf5Uz
 FZaUawgH+oipYGW+v31cX6L3k+dGsPRM0Pyo0sQt52fsopNPZ9iag0iY7dGNuKenaEqkYNjwEgTtN
 z8dt6s3hMpHIKZFL3OhAGi88wF/21isv0zkF4J0wlf9gYUTEEY3Eulx80PTVqGIcHZzfavlWIdzhe
 +rxHTDGVwseR2Y1WjgFGQ2F+vXetAB8NEeygXee+i9nY5qt9c07m8mzjABEBAAG0JFBhdWwgQ2VyY
 3VlaWwgPHBhdWxAY3JhcG91aWxsb3UubmV0PokBTgQTAQoAOBYhBNdHYd8OeCBwpMuVxnPua9InSr
 1BBQJdCoXBAhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEHPua9InSr1BgvIH/0kLyrI3V0f
 33a6D3BJwc1grbygPVYGuC5l5eMnAI+rDmLR19E2yvibRpgUc87NmPEQPpbbtAZt8On/2WZoE5OIP
 dlId/AHNpdgAtGXo0ZX4LGeVPjxjdkbrKVHxbcdcnY+zzaFglpbVSvp76pxqgVg8PgxkAAeeJV+ET
 4t0823Gz2HzCL/6JZhvKAEtHVulOWoBh368SYdolp1TSfORWmHzvQiCCCA+j0cMkYVGzIQzEQhX7U
 rf9N/nhU5/SGLFEi9DcBfXoGzhyQyLXflhJtKm3XGB1K/pPulbKaPcKAl6rIDWPuFpHkSbmZ9r4KF
 lBwgAhlGy6nqP7O3u7q23hRU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Felipe,

Le mercredi 15 avril 2026 =C3=A0 22:18 -0300, Felipe Ribeiro de Souza a
=C3=A9crit=C2=A0:
> Replace mutex_lock(&lock) and mutex_unlock(&lock) calls with
> guard(mutex)(&lock) in functions ingenic_adc_set_adcmd,
> ingenic_adc_set_config, ingenic_adc_enable, ingenic_adc_capture
> and ingenic_adc_read_chan_info_raw.
>=20
> This removes the need to call the unlock function, as the lock is
> automatically released when the function return or the scope exits
> for any other case.
>=20
> Signed-off-by: Felipe Ribeiro de Souza <felipers@ime.usp.br>
> Co-developed-by: Lucas Ivars Cadima Ciziks <lucas@ciziks.com>
> Signed-off-by: Lucas Ivars Cadima Ciziks <lucas@ciziks.com>

I see a slight behaviour change in ingenic_adc_read_chan_info_raw()
where the mutex is now unlocked after the clk_disable(). I think that's
fine though. So:

Reviewed-by: Paul Cercueil <paul@crapouillou.net>

Cheers,
-Paul

> ---
> =C2=A0drivers/iio/adc/ingenic-adc.c | 19 +++++++------------
> =C2=A01 file changed, 7 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ingenic-adc.c b/drivers/iio/adc/ingenic-
> adc.c
> index 1e802c877..bb7abdcd8 100644
> --- a/drivers/iio/adc/ingenic-adc.c
> +++ b/drivers/iio/adc/ingenic-adc.c
> @@ -20,6 +20,7 @@
> =C2=A0#include <linux/of.h>
> =C2=A0#include <linux/platform_device.h>
> =C2=A0#include <linux/property.h>
> +#include <linux/cleanup.h>
> =C2=A0
> =C2=A0#define JZ_ADC_REG_ENABLE		0x00
> =C2=A0#define JZ_ADC_REG_CFG			0x04
> @@ -115,7 +116,7 @@ static void ingenic_adc_set_adcmd(struct iio_dev
> *iio_dev, unsigned long mask)
> =C2=A0{
> =C2=A0	struct ingenic_adc *adc =3D iio_priv(iio_dev);
> =C2=A0
> -	mutex_lock(&adc->lock);
> +	guard(mutex)(&adc->lock);
> =C2=A0
> =C2=A0	/* Init ADCMD */
> =C2=A0	readl(adc->base + JZ_ADC_REG_ADCMD);
> @@ -162,8 +163,6 @@ static void ingenic_adc_set_adcmd(struct iio_dev
> *iio_dev, unsigned long mask)
> =C2=A0
> =C2=A0	/* We're done */
> =C2=A0	writel(0, adc->base + JZ_ADC_REG_ADCMD);
> -
> -	mutex_unlock(&adc->lock);
> =C2=A0}
> =C2=A0
> =C2=A0static void ingenic_adc_set_config(struct ingenic_adc *adc,
> @@ -172,13 +171,11 @@ static void ingenic_adc_set_config(struct
> ingenic_adc *adc,
> =C2=A0{
> =C2=A0	uint32_t cfg;
> =C2=A0
> -	mutex_lock(&adc->lock);
> +	guard(mutex)(&adc->lock);
> =C2=A0
> =C2=A0	cfg =3D readl(adc->base + JZ_ADC_REG_CFG) & ~mask;
> =C2=A0	cfg |=3D val;
> =C2=A0	writel(cfg, adc->base + JZ_ADC_REG_CFG);
> -
> -	mutex_unlock(&adc->lock);
> =C2=A0}
> =C2=A0
> =C2=A0static void ingenic_adc_enable_unlocked(struct ingenic_adc *adc,
> @@ -201,9 +198,8 @@ static void ingenic_adc_enable(struct ingenic_adc
> *adc,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int engine,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool enabled)
> =C2=A0{
> -	mutex_lock(&adc->lock);
> +	guard(mutex)(&adc->lock);
> =C2=A0	ingenic_adc_enable_unlocked(adc, engine, enabled);
> -	mutex_unlock(&adc->lock);
> =C2=A0}
> =C2=A0
> =C2=A0static int ingenic_adc_capture(struct ingenic_adc *adc,
> @@ -218,7 +214,7 @@ static int ingenic_adc_capture(struct ingenic_adc
> *adc,
> =C2=A0	 * probably due to the switch of VREF. We must keep the lock
> here to
> =C2=A0	 * avoid races with the buffer enable/disable functions.
> =C2=A0	 */
> -	mutex_lock(&adc->lock);
> +	guard(mutex)(&adc->lock);
> =C2=A0	cfg =3D readl(adc->base + JZ_ADC_REG_CFG);
> =C2=A0	writel(cfg & ~JZ_ADC_REG_CFG_CMD_SEL, adc->base +
> JZ_ADC_REG_CFG);
> =C2=A0
> @@ -229,7 +225,6 @@ static int ingenic_adc_capture(struct ingenic_adc
> *adc,
> =C2=A0		ingenic_adc_enable_unlocked(adc, engine, false);
> =C2=A0
> =C2=A0	writel(cfg, adc->base + JZ_ADC_REG_CFG);
> -	mutex_unlock(&adc->lock);
> =C2=A0
> =C2=A0	return ret;
> =C2=A0}
> @@ -643,7 +638,8 @@ static int ingenic_adc_read_chan_info_raw(struct
> iio_dev *iio_dev,
> =C2=A0	}
> =C2=A0
> =C2=A0	/* We cannot sample the aux channels in parallel. */
> -	mutex_lock(&adc->aux_lock);
> +	guard(mutex)(&adc->lock);
> +
> =C2=A0	if (adc->soc_data->has_aux_md && engine =3D=3D 0) {
> =C2=A0		switch (chan->channel) {
> =C2=A0		case INGENIC_ADC_AUX0:
> @@ -677,7 +673,6 @@ static int ingenic_adc_read_chan_info_raw(struct
> iio_dev *iio_dev,
> =C2=A0
> =C2=A0	ret =3D IIO_VAL_INT;
> =C2=A0out:
> -	mutex_unlock(&adc->aux_lock);
> =C2=A0	clk_disable(adc->clk);
> =C2=A0
> =C2=A0	return ret;
