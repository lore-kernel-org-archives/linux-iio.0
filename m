Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6EF91EDA2C
	for <linux-iio@vger.kernel.org>; Sat, 14 Feb 2026 14:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771079804; cv=none; b=lj4XuAufpc0tTom7ucFPfY4MLzQodRenLa3skUpkqZH4oxRiDYL/JPW+s+HcBAmyk4u9nLGsEqYNRZ1wUBovkNrdR/dmAcQfKs8qfcYG3YM1+Cds62y1hF0vZX5KsvUDHmA5jtnmqta+g7uI9ZB45gQBwK0bQfMoVQEM5GDXWVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771079804; c=relaxed/simple;
	bh=lifma1fkyJXoFbZdvaO3brzG5uu9xrpqnFcJ2/UiypU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W4/utKWk1gO5GKzn79+7/fUf4Lc6oQ4qtB44TBBGp8Y1dat2MU5qq3szzG83uZ5aqDlPPiMBRd28NUDm68LIwpCl2Lq7ghsPsCIAYUknqFSqN7oiTotUcUJ2jfpifE8zlvusCUltz5tvJt+JHdcY+Tka+/mB9/hNmowgMsV3K0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YBEhq7gq; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YBEhq7gq"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43767807cf3so1280264f8f.1
        for <linux-iio@vger.kernel.org>; Sat, 14 Feb 2026 06:36:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771079800; x=1771684600; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IX7asOCrGHlCJ3M/QOueVKWeSthQ1ahRVKGbE340Z6E=;
        b=YBEhq7gqGpZDqcxl3gzWIMTtdURVnSm80NlXvuKP2wJm+uAzlQ7+4DjkLYQ/lQoslq
         KExUq6zMI5achh3QeHwWKI9EVjuvJ80GqQ6uDK3zAcLK5+CAVC7J2JgsegynYmkit779
         5W47Bz4i+4DcU9OBDL0V3+ESbvOTao5TEqtucnJz4QKl9nmpXb9X6CQjgg3jU27Sa2lK
         cTXzAB/ZH9xQg+gWdIKTPauFdLFqFK+tlUnUwpS5eGJDba21jKtNoAGdnQsXyik7IVTg
         yjPry9jcC7Ns2484jzyXOhXJLy9aFzlBWsRGpEieSFNrr02wGCKx1E0idOz6JyGBOUpn
         RhTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771079800; x=1771684600;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IX7asOCrGHlCJ3M/QOueVKWeSthQ1ahRVKGbE340Z6E=;
        b=d3ig+q/lHA4O/isvT2CbccrdU8vu3gMpURLQy02aEx2rRleO5I6PCeVAGe1vArO4nO
         QZw/UCDiSF7sPQD9jIvfoVhpYID6DMgzM/XTIFJIPNh1uxiuFPB5uOyqTTVEYeirCJVv
         MbpelvXJjr409FwgTzUwJbAiaX4IRpO5eo/BvEsD5BLSkvOIU9XvJUGqtnr6uiSVDUjA
         M9cOfElRyOD9T6lt7wp0yoEVVuTZait+cb7BLTCmy+qumOfnzcXS2VfYObKSFmv4NrXE
         onmpauJDIyMatLhFW0UwoHRfOk8C5dUz0Et/a3JeJyNXjcNe2ze4D2OFoHmcmf/0nfyX
         cicg==
X-Forwarded-Encrypted: i=1; AJvYcCUJifo2PiolzCKKyq32EUXFVeTP8IEG1Bi7dQMn5nCnnF4uLvOqW9pdGO2KuF/n3eqtyhz3CzZh6Sc=@vger.kernel.org
X-Gm-Message-State: AOJu0YweZsfGoc64gJrQduP9AYN1dE64jwlFPi8nwzAtItB6KyCS8oX9
	yn0VPWzbaQVHpUia7e1TY/t+vKegF3dq7Xmz+90Sn5E1sl6WMNW8iGRz
X-Gm-Gg: AZuq6aIEXSyrrBdug+/7+GfsOMsCOjQKo+zvG2/4aMap2h6RGPt2c+iNZjzxQ/ZKfxH
	60tfnFsqbj4WRn3jPDXQ6r9avy1IH8QeFay3vCLeJ5so7Wa3iHgO8RDw4QU9gbnTz1biUZtuykc
	ShLWrn0Tqbz/ig4zUkOO38dV91J6+kWMK+Iaf/1ZRrto/nXEbMgg/D26w7NL3SpNblY3QoS8kuX
	u3fSbXQH3INLLiXiaeTImsURnt+qKTthT9LRmd8uBk96K93Ln78hlOc2fAuqe52lyExekxMyADo
	cczvMvRouYZ5uDkmo2NtDw3jxLa8Phsbb9vw7GR6wobsRgC6BBnletIWo0WWCHqX9swrTotoPlQ
	u6i4EpNRL5DYyCMDJICvEChDWblPPaqTvJ1HfjnojBMPWByJa2Tlg7zuJruIIBBQrZl/iklJKNS
	tKZAC8k4Mghf4+f/c2rJ/dT0ArRt1yHd2S6tv8KWL10tVHG6luvzLNYd9qPsLB42CnSARleALP2
	Fbc60BusC0GMwFSfQpUrNvRO4IXywKJ4gOJhe0ziNoLFOHvg2EU5HWp0jeG67buFT0=
X-Received: by 2002:a05:6000:2210:b0:435:b7b9:afe5 with SMTP id ffacd0b85a97d-4379db25e60mr4795742f8f.1.1771079799955;
        Sat, 14 Feb 2026 06:36:39 -0800 (PST)
Received: from HYB-DlYm71t3hSl.ad.analog.com ([2001:a61:1224:8901:285b:c5a:cad2:ba54])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796a6a6desm12994658f8f.10.2026.02.14.06.36.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Feb 2026 06:36:39 -0800 (PST)
Date: Sat, 14 Feb 2026 15:36:35 +0100
From: Jorge Marques <gastmaier@gmail.com>
To: Ethan Tidmore <ethantidmore06@gmail.com>
Cc: jorge.marques@analog.com, jic23@kernel.org, lars@metafoo.de, 
	Michael.Hennerich@analog.com, dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>, 
	Dan Carpenter <error27@gmail.com>
Subject: Re: [PATCH] iio: adc: ad4062: Add missing IS_ERR() check
Message-ID: <jy7aadqr7zblpoh2qvdelzjiqqjl5zpofckbuhhfeer3pjvcbb@ee47xydwo36f>
References: <20260214005332.29608-1-ethantidmore06@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260214005332.29608-1-ethantidmore06@gmail.com>

On Fri, Feb 13, 2026 at 06:53:32PM -0600, Ethan Tidmore wrote:
> In the function ad4062_sizeof_storagebits() iio_get_current_scan_type()
> is called which can return an error pointer and is not checked for it.
> Also the function ad4062_sizeof_storagebits() returns type size_t but,
> is only used once and the variable assigned from it is type u8.
> 
> Add check for error pointer in ad4062_sizeof_storagebits() and change
> return type to int so the error code can be properly propagated and then
> checked.
> 

Hi Ethan,

Thank you for adding the check.

Reviewed-by: Jorge Marques <jorge.marques@analog.com>

For risk assessment of the bug:

  static int ad4062_get_current_scan_type(const struct iio_dev *indio_dev,
  					const struct iio_chan_spec *chan)
  {
  	struct ad4062_state *st = iio_priv(indio_dev);
  
  	return st->mode == AD4062_BURST_AVERAGING_MODE ?
  			   AD4062_SCAN_TYPE_BURST_AVG :
  			   AD4062_SCAN_TYPE_SAMPLE;
  }

  There is no path where the method returns an error.

It definitely makes sense to add the inexpensive check, since the
*_get_current_scan_type could be patched with an error case (e.g., added
support to other devices) and the lack of check could slip through (due
to previously marked as false positive).

Thanks,
Jorge

> Fixes: 23cc92280302d ("iio: adc: ad4062: Add IIO Trigger support")
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <error27@gmail.com>
> Closes: https://lore.kernel.org/r/202512280539.AholFF7m-lkp@intel.com/
> Signed-off-by: Ethan Tidmore <ethantidmore06@gmail.com>
> ---
>  drivers/iio/adc/ad4062.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad4062.c b/drivers/iio/adc/ad4062.c
> index dd4ad32aa6f5..c864de3b46ba 100644
> --- a/drivers/iio/adc/ad4062.c
> +++ b/drivers/iio/adc/ad4062.c
> @@ -1199,11 +1199,14 @@ static int ad4062_write_event_value(struct iio_dev *indio_dev,
>   * The AD4062 in burst averaging mode increases realbits from 16-bits to
>   * 20-bits, increasing the storagebits from 16-bits to 32-bits.
>   */
> -static inline size_t ad4062_sizeof_storagebits(struct ad4062_state *st)
> +static inline int ad4062_sizeof_storagebits(struct ad4062_state *st)
>  {
>  	const struct iio_scan_type *scan_type =
>  		iio_get_current_scan_type(st->indio_dev, st->chip->channels);
>  
> +	if (IS_ERR(scan_type))
> +		return PTR_ERR(scan_type);
> +
>  	return BITS_TO_BYTES(scan_type->storagebits);
>  }
>  
> @@ -1233,7 +1236,12 @@ static int pm_ad4062_triggered_buffer_postenable(struct ad4062_state *st)
>  	if (ret)
>  		return ret;
>  
> -	st->conv_sizeof = ad4062_sizeof_storagebits(st);
> +	ret = ad4062_sizeof_storagebits(st);
> +	if (ret < 0)
> +		return ret;
> +
> +	st->conv_sizeof = ret;
> +
>  	st->conv_addr = ad4062_get_conv_addr(st, st->conv_sizeof);
>  	/* CONV_READ requires read to trigger first sample. */
>  	struct i3c_xfer xfer_sample[2] = {
> -- 
> 2.53.0
>o 
