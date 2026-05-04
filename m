Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880A528DB46
	for <linux-iio@vger.kernel.org>; Mon,  4 May 2026 07:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777878686; cv=pass; b=QPebcaFDehPSPnCKFo3NFBPNdFTB3a4a3m3P9mRrZdk7SHd6eV3DbPd9RJ0dIZ5OUp2y55jmWBoS/yY+8wPbQLqduN80G6cKoZ9/RQWd52WdOo6kGY8zicOSKIl08iDnXTA99uyc2IY0qvWht2bhUOwASiZt9ZMyiWDK0G5v5HU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777878686; c=relaxed/simple;
	bh=kglGFqTRuHdhpQWBtE+dncc99Brm0kgGL+3UsWEoczQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T3kuutqoMzWN4W8Hdr0fUEug1SnRM3YHq0U23Ho3mLiEDJ23IajM/287eGYjTG22Oef+jd4Gh2lYGte5jho30FCrHRIm1oG8Fd2zf9N9PbaT7XsEF+2A16zichXBLjrFYir7AvkqWACYHXbU2FR0N2J+m/Cb575w7RJcNmu8QXY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SiwbdabX; arc=pass smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SiwbdabX"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-43fe62837baso1902543f8f.3
        for <linux-iio@vger.kernel.org>; Mon, 04 May 2026 00:11:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777878683; cv=none;
        d=google.com; s=arc-20240605;
        b=OosFG7nYoz6C9UQixaAiiMNu1LuwK71eQwoVYr2OEVnSHtl4U2Rp3D2aTRkc3Ras9I
         HqMKWCBvNfUqnN+kTUIhbW6nipe2hi5I5BzU1E7Pd304FzAzk5on3DnY1v6EH4VIAY/H
         6GQT3a9YfEZOyWlsOrV/dZ7ZteHJSF2ZNuGfqBgmoSS6mC6QqpXlrSx3/7x3tHqQRL9B
         GCLh8qRlq8gI4CcgXvc6czImOEdnpY4NjF5rupJNjcRCyhYiMx72+eYCN04pGNR54Sp9
         QY9Zr4d1rP9nmuQb5/aYQ8UPq6sjVoI0f6PHercVDZYLEMHM8IwNIHGL0LufVsdypdY4
         hrsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=NvGD5c9l1ivWKJ+fVvSVviigDGceZ9x5XbMt0sUPazI=;
        fh=M/GxNuWZNBic3mYa0riF9Fc88H3xCtaR5WemNKXmtSI=;
        b=BHk2IYIR/UhoY0K9VVpWfoLcmACCioXbONVQ83406NLzwlUfSKQLKZdETuOC+Ey8Gz
         TrHe+OkQjpk4XnxFnUZu80ZNEWXe5ud5Up90j834mgmG+ktZuJpgJV5Oipx+91vh3lvB
         eu8kUOROrztgpYR6N6zwpFlbU05u3OBr+/a0SIRj03K5SRVAl4q9/bF1CJJnsDLQrKly
         BeplYhU/SRHcfGvZFYSQKXq8Be4r5AW5Vor8xKNLZWI21o9p5I9SqOtbskvz79ugHNSv
         8hDrZNM3N7GY3N/4DgcxzzTS6KuKwrBuXQxQxCZ3f55vqQkxDKqanlK0oZguZ79387NT
         ZMNg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777878683; x=1778483483; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NvGD5c9l1ivWKJ+fVvSVviigDGceZ9x5XbMt0sUPazI=;
        b=SiwbdabXXBL2tdOU2BKKCwCLu/4cyH/Uv1xZxif+zIsniaswmJZNt8wu7zKC8FDuCu
         dZqLNGDEOYU9646VqLC8gbtTv1qaqIcAUC2+W394Lh8Kz8BpqJj1ld9mIfK4keDiHrq3
         TjYC4iLGgByc5t53i2icO2DjSWE3B1ZwUemLAWzlaHz9tiOgt5y7sYYawa6oLX2k/HCR
         ED+R9xOJMYSR+9YBzQ4zpzys1hlkIrExl+nTK+KXWZq8KaxSeDlZ2xL1omIEvlW88uPA
         51UPwjVsqEUWbPJC+5yqO68N8ZSFaeMN4z4nDFtP8azd13QvLzpVoZI2gDYZWmtbLp5f
         bQsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777878683; x=1778483483;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NvGD5c9l1ivWKJ+fVvSVviigDGceZ9x5XbMt0sUPazI=;
        b=FoUQnW0OVv573cHMHboopOpXrTHDU/yh13IQ0zwiqHtl3h5R/kY7BWfXLYFtImNJAg
         MKt9p1RSwX4NUCMg3WrFF1zU0Ui+ye/MIVZe0IFNvUPeYZ/CFAJ8VwIRQWEG0dhrj8nU
         tCxli8nmiSJVYwMvM+n0QuEkWxMjorqoJ27GM1n0gJ47YlS9dGlSFbazWmw9f367uAFi
         pCdz+MRO2H1aOAf3/iBGDB92Qu4TqVJAFVmMDLVKaugs5gujoen8Zp3nTjLExKbCZ9QI
         b6hDKteJDD/LcbaT5wuFBXASEEraJykuyoYFBkPIeBF1kXXPRjtg97OixCegZH6NYKvL
         7cmg==
X-Forwarded-Encrypted: i=1; AFNElJ/f/k9swSxdidvOwzEEP6qDjd0S5rcyo2Tt6SDgQvAosgSAlxP2rGhTk2TyVufvn7oaYbj4WU+Y+cM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3E49I4dutiXrENIq0jbNknUScp+H55axbIS4Yj4TYLCKftIv7
	fRBwYScTUPtQMRz4iZZLrt6jxi6oOAiZ0HDzNBgCFESdU3iow5NxatS8Q52gqgPd3RRvEx1IAKh
	dwt6+FxAHO8wIYWokQjoD2scGuvBTK34=
X-Gm-Gg: AeBDietgQDhIYDP9Xksb2pxKVZ2ITq4aB5tC+ZombCy7Wg3NHomhfuDn955ejq57qao
	9XYM4ighPYAGxqJVwM1bViQr+0W/n229Euahg3zHp/RJVEqMmm8fYJDQY/yp100MOKWZckkUu4E
	dkwhIBPVL5JnbUqg42vUUF9GoVO/a6i4zZDN2X8adiAgZvQIJx6TphO6AfV4/3hGXJTIgn7SZk1
	WrvXfssXeH8KrXaFd/V7rhaPfp7bdN5mDBKsFfbmtx7WUUe3nXo0b/5Wuki0JLKZTJGuQh+dLFx
	jPR2ZpwDzF3QfhqslcjyYmCFN1vlnGJOcEKRB2HVldopVAib122M973nbRLMSBIip4tlwEAfADC
	1s3/8Ure0ZSvi6b+C5Dz8Wz+9LpUiSRjHrrqKZuL0G+1x9To+n/zhmAjdZmR0pfq1SkTUCxFjqK
	Na0LBy8CBhcqf3OxIL
X-Received: by 2002:adf:fc0e:0:b0:44b:ce43:e319 with SMTP id
 ffacd0b85a97d-44bce43e32cmr7844439f8f.1.1777878682776; Mon, 04 May 2026
 00:11:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260504030408.105762-1-limiao870622@163.com> <20260504030408.105762-4-limiao870622@163.com>
In-Reply-To: <20260504030408.105762-4-limiao870622@163.com>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Mon, 4 May 2026 09:11:11 +0200
X-Gm-Features: AVHnY4LEB-lWzxIbh0FlBIhCPViuqgLW9kt_O3Y_3zgJyvqNpkGdhnhMuAOomZE
Message-ID: <CALoEA-ze3GGeXN5po3EwztH8Kod+NBtrKa7mJ+VU5wUJO-AHYw@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] iio: light: stk3310: Use sizeof() for
 regmap_bulk_read/write count parameter
To: Miao Li <limiao870622@163.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, waqar.hameed@axis.com, dixitparmar19@gmail.com, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Miao Li <limiao@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"

On Mon, 4 May 2026 at 05:05, Miao Li <limiao870622@163.com> wrote:
>
> From: Miao Li <limiao@kylinos.cn>
>
> Convert the hardcoded count parameter to sizeof(buf) for all
> regmap_bulk_write() and regmap_bulk_read() calls in this driver
> to improve code maintainability. For details, see [1].
>
> [1] https://lore.kernel.org/all/20260428192213.7c5c80e5@jic23-huawei/
>
> Signed-off-by: Miao Li <limiao@kylinos.cn>
> ---
>  drivers/iio/light/stk3310.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/iio/light/stk3310.c b/drivers/iio/light/stk3310.c
> index 0447fbf1b..74ee75721 100644
> --- a/drivers/iio/light/stk3310.c
> +++ b/drivers/iio/light/stk3310.c
> @@ -258,7 +258,7 @@ static int stk3310_read_event(struct iio_dev *indio_dev,
>                 return -EINVAL;
>
>         mutex_lock(&data->lock);
> -       ret = regmap_bulk_read(data->regmap, reg, &buf, 2);
> +       ret = regmap_bulk_read(data->regmap, reg, &buf, sizeof(buf));
>         mutex_unlock(&data->lock);
>         if (ret < 0) {
>                 dev_err(&data->client->dev, "register read failed\n");
> @@ -298,7 +298,7 @@ static int stk3310_write_event(struct iio_dev *indio_dev,
>                 return -EINVAL;
>
>         buf = cpu_to_be16(val);
> -       ret = regmap_bulk_write(data->regmap, reg, &buf, 2);
> +       ret = regmap_bulk_write(data->regmap, reg, &buf, sizeof(buf));
>         if (ret < 0) {
>                 dev_err(&client->dev, "failed to set PS threshold!\n");
>                 return ret;
> @@ -376,7 +376,7 @@ static int stk3310_read_raw(struct iio_dev *indio_dev,
>                         reg = STK3310_REG_PS_DATA_MSB;
>
>                 mutex_lock(&data->lock);
> -               ret = regmap_bulk_read(data->regmap, reg, &buf, 2);
> +               ret = regmap_bulk_read(data->regmap, reg, &buf, sizeof(buf));
>                 if (ret < 0) {
>                         dev_err(&client->dev, "register read failed\n");
>                         mutex_unlock(&data->lock);
> @@ -726,7 +726,7 @@ static int stk3310_resume(struct device *dev)
>
>         if (data->ps_thdl != 0x0) {
>                 buf = cpu_to_be16(data->ps_thdl);
> -               ret = regmap_bulk_write(data->regmap, STK3310_REG_THDL_PS, &buf, 2);
> +               ret = regmap_bulk_write(data->regmap, STK3310_REG_THDL_PS, &buf, sizeof(buf));
>                 if (ret < 0) {
>                         dev_err(dev, "failed to set reg THDL_PS at resume.\n");
>                         return ret;
> @@ -735,7 +735,7 @@ static int stk3310_resume(struct device *dev)
>
>         if (data->ps_thdh != STK3310_PS_MAX_VAL) {
>                 buf = cpu_to_be16(data->ps_thdh);
> -               ret = regmap_bulk_write(data->regmap, STK3310_REG_THDH_PS, &buf, 2);
> +               ret = regmap_bulk_write(data->regmap, STK3310_REG_THDH_PS, &buf, sizeof(buf));
>                 if (ret < 0) {
>                         dev_err(dev, "failed to set reg THDH_PS at resume.\n");
>                         return ret;
> --
> 2.25.1
>
>

LGTM.

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

-- 
Kind regards

CJD
