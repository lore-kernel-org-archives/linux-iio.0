Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9176432A3C9
	for <linux-iio@vger.kernel.org>; Mon,  4 May 2026 08:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777882779; cv=pass; b=NRMME8OmrjG2E/VUA0+KGKVkNx3zXjFc6xri5DTdRyxlbD+UEYtHakP3AzIS/kpXkOxIsRBvR95rWwm9aCn74HykoMNhTaxe6/QI1KHqshWzIbeUTtWg2+R5FAv+CZgbmYBk99Y5U4RpkBwZswqfzGZ7R3KkNZd7HbCOaTnDdaU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777882779; c=relaxed/simple;
	bh=l8ZpdzgxNTWWmScT07aFRo/bLAkMwCRgPYeEZ/E4nt0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JIu2at908zlJNAIk9D62yYcUxIyq984+BQQtAmSEAF+dQUVEUnQH0VR4KgwpzQW9a1rcLnoRz3zoGPnvK+OQATVmwTGNuFOx8Vhw/GAUXMKOihcu1kOeoZ3w6mDJRAGBkMd79zKchRAkvsGlH4z/eS/V043lUaK0YsuDomSe3yk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FerO2FDZ; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FerO2FDZ"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6763cc8775cso7985027a12.0
        for <linux-iio@vger.kernel.org>; Mon, 04 May 2026 01:19:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777882772; cv=none;
        d=google.com; s=arc-20240605;
        b=dXxmykPSmA0dkfA0vw+muEb4y7bLwg1ZJTE9czcCvlZsc0/LNgQE1WY4WOV4dq0awz
         k5o9JAWFa3523Rn1lY6tQceWH6dDvpDnVZTGwhrokIF5WtXxut1jShVycJacxBbttOUg
         H7lp9CYRys3oAg81HdpFpX1EgzRKquU5M7Z1THlOWfl99sSVN7dXEe1hRF6MH6rueZVu
         qMVPz6O1YiOk7Y+TFGAL4KmbOkDlBwe6028FYbvrjbZISMdkgtx8/e0O6MjU0aZ76GXn
         R/Zmg6zKmYq+AXG2R1McBC60wLetAcPlvtcua9+hbkr6W7vFuE7+AKM5rwPk4YU3Q1fc
         wS8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=c5uzeGe7MO2cASOiiw8a/Glk5CEUpsfLNKgiAwc1nL4=;
        fh=b9AwDXNEG/wd2F3KS7QABczAUpIslUtXei8ujT8rz1g=;
        b=XzOjQt/XmEHx7AJ3+MM2D+bT2Yt7GZwuBtBQLY+E/7Q/6x0+N3Kqta2RvlFwhO7SeB
         WVkobeYUKx0hOthjcV+aLrb2huZKAJJlsT5z4jsbW/EW9VqkCvbnjuywemFDDCzIskDI
         S7d4giEcTqOxUuXVsJKYewqVxtBwljVaOCmSxDBDr0JLP5K1SoSDz4QyjGPhEjIj9ij2
         LEIG5yTQbA+Fmixq8DdD25VdZZ1kGVyvC9XGCrvZXu/wHOxaZmZ9rpVhARx/lpHRmlad
         8nq2BV+rK4+d3c9qpWz+hjW+csA390+J209EdJ2fDZpAVFTCsQ3D/O9brsJLAC84Dm60
         NonQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777882772; x=1778487572; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=c5uzeGe7MO2cASOiiw8a/Glk5CEUpsfLNKgiAwc1nL4=;
        b=FerO2FDZnkBExdgzx0PNCC+wW1yyi4iwMFm0zfBmUw89nxeSjw5j7tG0S+smclNeZP
         9AZANXywib9tuMEHI3aJGfHbjoni8jjVqJtgieb4Kq5YOBQIXqASpa9iJ58hqohXi+BR
         3eWp1G0rhjuEaAe537D3xvtJ1i14wEamb4qSuN3lOnxD9kqBCfYol0yiEKK3l61pEpXA
         7RbTqljyzSGfYOg/jgpIwB4LgVX7AAWMtKqg6jagUmZs4r7/3HzU6pBRNJGzaNhCIePI
         0uYtdL5v9XcVxjUfBo6Pbc2EIddsq7bERog4KMfeKEAydLoWcMw5vITqKY4vYGYyieZG
         jysQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777882772; x=1778487572;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c5uzeGe7MO2cASOiiw8a/Glk5CEUpsfLNKgiAwc1nL4=;
        b=gLsmJbIDBpJ6+HIY1sT/99QCATl8dAeY39ipupK+lCW15QruySHzrTbTepcor76EDs
         e7zwrs1YwhYb6MiyoVtQUiSitci6l8gJY3ixQ2mUcUC8t9T30Wpb1DfriNxP/zOdU62r
         CTmT2wk4+ML6cv/5KtdgrUz5XH0f3otQf8Dpmt2mndomKGhSWnismfpd7l9z8aiX9iJ+
         gKDfN8Jnda4FE6eHgeaFtybvIKqS/duPlB41JsX7Tbi+Lmd+j/5KFVdHDb5kCPfm0UNf
         VMd0L8P/14nk1qe2PtskuLUsbukK+lZZ/WSlTL1yBksoYg4kLmV0Spd/4JxronWs4Z5L
         1eIQ==
X-Forwarded-Encrypted: i=1; AFNElJ/GKrBO0vLhZLCJUxPkkgR4GMrNIhw92j716qS61JXKH6PQUdjeL5GYZeOy7vNVFOLiRHQKQq8tqDA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzE8TKGdTZj8gkZ0Rvi7zKc4p7VN0xp1/NoOMISSBrsTxoez+Su
	mKFj7Hd1eRQavjpWtaOW22G9YHBO7DkzSj2TV9GbGLqdHoiEyvCuEyyW2YKfevXjYtMYZGyyA9F
	aOJi/95AABl2rMUQUE8WJdSinrGvVv6mafykH
X-Gm-Gg: AeBDiesROMT1brq1StSWC15GmOWkmtKi6q0XkNJfQyQOwqUDkG8w9NXAcoFiiv17d1K
	43ZFoqINpYQ74FwWCKvhPa/A02f9uZlaf5mhmt2B8Nj7g++CgB10kG09A8F22UrAMv8iH31es3U
	hulzAf98q1KaCyY7T8Q53vh+g+u44s/5IY93LhCp0+MJphuJ1ouGFdhSu2Xw5k/SnnC4MvMQB46
	2w+LNkD4jB8KIxsfVI9aWyn2lNslyj9ym7CBjTKVO5oUIL5x82F71k5SvymAiaXaT3G+OgTCzpG
	9PKIN2F2qlPcITU/OKz6/LBEJaOpF1RpyLkCg8/KeGrQE2OUuL2dkFbm84Rr8N5572KpgTK9f5T
	P7HkddDO3CHWOKduaSfZrWLmYZ9+M88NLf65Fr3zC3MARjCoh/J7x4GDLPBmr8ejmQTpVgBivvE
	r9QdYO/lLyr8R+knsxcuriZKz4d14=
X-Received: by 2002:a17:907:86ac:b0:ba6:74bc:5604 with SMTP id
 a640c23a62f3a-bbb98a74d59mr709405866b.26.1777882772104; Mon, 04 May 2026
 01:19:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260504030408.105762-1-limiao870622@163.com> <20260504030408.105762-3-limiao870622@163.com>
In-Reply-To: <20260504030408.105762-3-limiao870622@163.com>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Mon, 4 May 2026 10:19:20 +0200
X-Gm-Features: AVHnY4Jrmb4Z6kDtKTA6VlZCJo_VUCkJjL6_q77TFmyyMbN9cKd77Zy3i-HX5BA
Message-ID: <CALoEA-z6mR-Qb4CwYPoBjCjMZURF48zs4Y14TXfsTf2=skyOHQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] iio: light: stk3310: Replace uint32_t with u32 and
 reorder members to eliminate padding
To: Miao Li <limiao870622@163.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, waqar.hameed@axis.com, dixitparmar19@gmail.com, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Miao Li <limiao@kylinos.cn>, Andy Shevchenko <andriy.shevchenko@intel.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 4 May 2026 at 05:05, Miao Li <limiao870622@163.com> wrote:
>
> From: Miao Li <limiao@kylinos.cn>
>
> Replace the uint32_t type members in the stk3310_data structure with u32
> to adhere to the unified kernel coding style, and reorder the member
> variables to eliminate memory padding holes.
>
> Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Signed-off-by: Miao Li <limiao@kylinos.cn>
> ---
>  drivers/iio/light/stk3310.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/iio/light/stk3310.c b/drivers/iio/light/stk3310.c
> index 86cc6e8ec..0447fbf1b 100644
> --- a/drivers/iio/light/stk3310.c
> +++ b/drivers/iio/light/stk3310.c
> @@ -115,12 +115,6 @@ static const int stk3310_it_table[][2] = {
>  struct stk3310_data {
>         struct i2c_client *client;
>         struct mutex lock;
> -       bool als_enabled;
> -       bool ps_enabled;
> -       bool ps_int_enabled;
> -       uint32_t ps_thdl;
> -       uint32_t ps_thdh;
> -       uint32_t ps_near_level;
>         u64 timestamp;
>         struct regmap *regmap;
>         struct regmap_field *reg_state;
> @@ -131,6 +125,12 @@ struct stk3310_data {
>         struct regmap_field *reg_int_ps;
>         struct regmap_field *reg_flag_psint;
>         struct regmap_field *reg_flag_nf;
> +       u32 ps_thdl;
> +       u32 ps_thdh;
> +       u32 ps_near_level;
> +       bool als_enabled;
> +       bool ps_enabled;
> +       bool ps_int_enabled;
>  };
>
>  static const struct iio_event_spec stk3310_events[] = {
> --
> 2.25.1
>
>

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

-- 
Kind regards

CJD
