Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794095620;
	b=GkatZxYNkPQYnltjtqGTFNbUniH1ep/Ajcw/3N8ywllrI/APAnwhDuUvfzqgJ0c86gnq
	 9mhfLVO1DyaEkg8+tg9JdlcRwvu5yfQmSj6Pma1MMQrg+3imeJVn6oBjuotHKJ5SI+Hi7
	 5dn7KCZ357KW5PzL/uhlOR+YBAqYvgj2UxqqFKcr8Sr2Simtaxp4Hx3a5/DvOsmUbh2Zl
	 mWHd1owJBLsqjyrBSrHcQwE5k83qBfzSBibXvdghKB565RZhaMf1yK4sAlAHewM2hVpiA
	 HbcnPbzMzDQ8gand8pGKuoyj3jdkMKBsmFLPGxxpzi84MTHQCdfx92q0XEXjGPFv0dA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794095620;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=KHl7FjLAzlF40pqV1aBsWmS/0qukI7VrjXFs4bBB8lA=;
	b=NkxogIcWiV72GxHbkc6lrIEQ5c7QDKmHA5ahv+U0BSxGk/NP6uHh9/9c6jIo8LoyhjiU
	 QFYSm+h6ro+xcmPq20GevkG3PHEokHCtEMAj4HBHr3rmkPF9CS5UGlfhAuzZFkC0BEP2D
	 IDQvh8yYuB4r32EK+YJ321rvSTJEVlnveUhQS3TjJpOgYELcPJOMYjPfmuoxAYmkcX3Gt
	 tfQRXYvAo3n7WOpuhSlgkITUU9+sfqeDVs/D9uDnChVVIv9u6CDQnsa/sk300pfHOBefW
	 KJbBhIUqkoKDHHwf5Q05ol74PyP/T7Y9HcHcyyWXLkwWb7Dh8jxUChEJw2O+ixocclA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=HMu0EXKl;
	arc=none smtp.remote-ip=209.85.214.176
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33FEE606A32E
	for <linux-iio@vger.kernel.org>; Sat,  7 Nov 2026 23:53:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33FEE606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=HMu0EXKl
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2e9d7791b00so793645ad.0
        for <linux-iio@vger.kernel.org>; Sat, 07 Nov 2026 15:53:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794095618; x=1794700418; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KHl7FjLAzlF40pqV1aBsWmS/0qukI7VrjXFs4bBB8lA=;
        b=HMu0EXKl3AkHe2G5WW57J0UAthtyRuDWCwgQMIDulH8hT6pVxVx3fUoSA7RxMy2hCg
         oSqb+2Z5R5X/AVJ3E9+fNuFL9yjHeIhIq2CyUhRHc/WZoepDZvqNyDuK6gpl3YDDZwFL
         cngmZ8F0oSqa5FV/6a/ycrpTefPf3DC0xgfWGp7FUJvzHcXS+SHTrhBzbOnH2rueLuU7
         bRn0ieLddPKFeTfETtbbkH41UQ80PjR2mQCm1mh/yKywCXajWEXpm9vQZhRV7Es0e57g
         NcgonmwSV+12Q5Q5otUWByMVTLNAhQHpvDuIHlD0ni6g24Cy+3bwg8+FPZ5mfqXLStfd
         SrMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794095618; x=1794700418;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KHl7FjLAzlF40pqV1aBsWmS/0qukI7VrjXFs4bBB8lA=;
        b=SET60aYFwXDswPqVnir/tVi1hXhpVvo7DZvh7lBtb5e1jSll+6grIVjaf0jK71b7Ro
         hbcyLnWHN2Rd3BMd4NdAcj4ID6JmBBnX1Vf/W8AqAWXKFH25EZU1euXvB51UCHwyL5nh
         X3CQWM8LD1LiZ6Cfirf/IW0++tCjZE1R+W+r3oc5SFtB1Ut5TWzXRS2T0tyf6SsRnO1y
         zgiOtvme5GFUHkue5Se/Jl1G8OLPkVRjeGcASFWAqlDp61it6ZX1oRwNQRU1dtoezb4y
         CuYg608vwGWClioU3Nyo0aUnq7PcbR/QOr8TIn40rXs6QU5sSW13atnYFlmbrSa0ZP1V
         TqTg==
X-Forwarded-Encrypted: i=1; AL+hErG48ww95b/xK4Hz3Empp4dnezzohJja/H9zJUiYM18vgHWpCmaFZGdBS2qUB8mr1LFd1UKxagJonZA=@vger.kernel.org
X-Gm-Message-State: APuU4Z9jyAMMGgai5ghlW833TooffCMh4kKh2tv1PDOQu81WDVNLMXe/
	dSmbS/XloxHwUjR/oxyRpaSv9MgQAkHveolqcUFfFH9vdCX1g/e6lviKxpbQww/q/w==
X-Gm-Gg: AYBFou22TIYWv8fq/YCkTCQh5pUiI/JvvLh8Ykup60yFEmk2Lg7Rz4ZQTqXBbKQDxiW
	conbYnd+cs4MLSwZNwqzr7mr8w4cJC9d8U1ptw5GYcuFSYL4T51klXd8Y5m5jIk9WFMevixKy4d
	5xf7y1eFW+sEGNMQ7IGgswsBCqc7UNP05qyY022V16Cf4PnllKb4ZwyeNcORZ97N4kwOq3nfuqD
	rNmYD4Ea8rGpupVFFVFZZYQDEv97+mjT2uCUlrG7cRr3sFGs4Ckf3EKqBwVFAqCtMGk1yyKohCG
	+FQHR+RXFgcnJnkJHMyK9Y8nx3JS/4bhi9JvDYSJpBf4fyPKEI56GCi+BXzpxCStpSFXLSP6ACH
	9NLoJLYwMWYAhDtsLbShpVVEU/q2qxMBRNqmuUf5c7uTNLXLssnBxooqtFQllEvClrkyzgc8FJ9
	0RUGPCYqNc96Ik2kSgVFpFaNvhchkH61G+g+PCiQqpdZk0XXjAa4No0D7lyu87K+MrqxG6Pehhq
	tE6t/xGdF3Q8TDBTeRatTzJ9lNF15M4FxX6kKxROxaOjtZgAHU26p8E4hMx+5lsNk89E/UH0sxb
	KqjhF5N7WTOBYxftkfndCDq+DY6NIWxnQufR5PY1MULXvcwk18oQmhGutfo/Jqap0WEym2VHvZC
	Kyc79Vn4KcaJLJdYLztV/HQrNYo37FL63mlLRPH3yATHAtPiM147EXVFJFcybaoP2fWVY1NVHE5
	QRCT5t4NI2
X-Received: by 2002:a17:90a:df0d:b0:3ac:a203:e092 with SMTP id 98e67ed59e1d1-3b12d0e72e1mr64263a91.1.1794095617777;
        Sat, 07 Nov 2026 15:53:37 -0800 (PST)
Received: from google.com (196.126.197.35.bc.googleusercontent.com. [35.197.126.196])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b127712bd7sm678574a91.2.2026.11.07.15.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 15:53:36 -0800 (PST)
Date: Sat, 7 Nov 2026 23:53:33 +0000
From: Benson Leung <bleung@google.com>
To: Daniel Balint <dbalint@google.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Benson Leung <bleung@chromium.org>,
	Lee Jones <lee@kernel.org>, Tzung-Bi Shih <tzungbi@kernel.org>,
	linux-iio@vger.kernel.org, chrome-platform@lists.linux.dev,
	mfd@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/3] platform/chrome: cros_ec: fix alignment of
 ec_params_pwrmon
Message-ID: <au-5_dDwdf0j7kDi@google.com>
References: <20261106193129.43493-1-dbalint@google.com>
 <20261106193129.43493-2-dbalint@google.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="SVqnLzRLk3+00m3z"
Content-Disposition: inline
In-Reply-To: <20261106193129.43493-2-dbalint@google.com>


--SVqnLzRLk3+00m3z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 06, 2026 at 07:31:15PM +0000, Daniel Balint wrote:
> Sync EC_CMD_PWRMON structure padding with ChromeOS EC firmware by adding
> explicit reserved padding to struct ec_params_pwrmon (2-byte union
> alignment) and struct pwrmon_dump_info (4-byte struct size alignment),
> as __ec_align2 and __ec_align4 expand to __packed in Linux.
>=20
> Fixes: b57af7f8d194 ("platform/chrome: cros_ec: Sync host command header =
with EC")
> Signed-off-by: Daniel Balint <dbalint@google.com>

Reviewed-by: Benson Leung <bleung@chromium.org>


> ---
>  include/linux/platform_data/cros_ec_commands.h | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/include/linux/platform_data/cros_ec_commands.h b/include/lin=
ux/platform_data/cros_ec_commands.h
> index a7bd69d83522..6d74371c7074 100644
> --- a/include/linux/platform_data/cros_ec_commands.h
> +++ b/include/linux/platform_data/cros_ec_commands.h
> @@ -6635,6 +6635,7 @@ enum ec_pwrmon_cmd {
> =20
>  struct ec_params_pwrmon {
>  	uint8_t cmd;
> +	uint8_t reserved;
>  	union {
>  		uint16_t set_rate;
>  		uint8_t channel_id;
> @@ -6651,6 +6652,7 @@ struct ec_params_pwrmon {
>  struct pwrmon_dump_info {
>  	uint8_t channel_id;
>  	char channel_name[32];
> +	uint8_t reserved[3];
>  } __ec_align4;
> =20
>  struct ec_response_pwrmon {
> --=20
> 2.56.0.455.g6c5a503b38-goog
>=20

--SVqnLzRLk3+00m3z
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCau+58gAKCRBzbaomhzOw
wupqAQD31+MHMT2GMHa+8gZvTeOGQWK/Ucg+s4hL5AvoDdccuAD9GxQ4UPJP/cxM
xa6kW3kvabTLe+wjpkqkA9kC7jHj2Ao=
=kCAn
-----END PGP SIGNATURE-----

--SVqnLzRLk3+00m3z--
