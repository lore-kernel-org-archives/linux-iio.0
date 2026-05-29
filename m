Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575A33375C5
	for <linux-iio@vger.kernel.org>; Fri, 29 May 2026 11:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780052882; cv=pass; b=HccczFjO0usUo5yFCvtm4DfoCs7XnSI6mARpCGvUg9ns0v0602gq8EmtGM5877Y9dKxs0H9pK4HymyqnKKfCTJ6oPJBrTAZNndZ9KAgJkNAivPVWNlce9hTTPLtGKqMUezVqjxP3gjFINPdIZkAUaB/bJpHw8q77Lib/OjDfzYA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780052882; c=relaxed/simple;
	bh=obf9z29L5Lqqmiiiicky94RVLYmHTDWjOqgvJ9lBlbw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K5VyO/HmJv0ZViRgJJhkb8xopfC76R/eNw9683IHp4n9cEQEaKCrX0YrWAeIlGpQ4EuKKlO+nDHwQq/S3pMUNPGob9cDNP9UPnbjfI4Oo/K6rn4vYQq76OKoN9Y/Sbj6KsX4qHOkQmq11t9z1x3pWsdhvkq5nFKXLRiDMYfaGtU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sa7AOjCw; arc=pass smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sa7AOjCw"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-45ef5146b56so149159f8f.0
        for <linux-iio@vger.kernel.org>; Fri, 29 May 2026 04:08:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780052879; cv=none;
        d=google.com; s=arc-20240605;
        b=EVS6jOqMFwG6IVYxmAJh1iyX828pLn+FbDrrWlPlPUpEHj9RaQiukHcUi8Tqi8kfdT
         bTBKTVC16hQsZdQLMxLxeqA65tzOsG1io8h6JU89sa66Fu9qWWGVtRMlF4yKh9v1/XYB
         vpcqcFh15quiviPfzg/VSGZGBZuAK78N9rOmaHAb6vIt11aRa5MjGFG4tgRW7W0zA/tn
         7sgZBE6ts1Vm5tGpvHIKlKOq1asEFLU1tibyrydqglfe+ZTl9M3tdS3Ma5qrOaJdpi/v
         1GiprkUfMJ1J9TXwHEIH+LKpvvrS4ioJotIbkaW6B+L176r9cdSsm1EuxDFxUPmQIs8T
         SAXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=K5d31O66j14PfHF0RDLXw35l15NLOx/uF0bU9fTRqGM=;
        fh=xltLFL0DSNGaF2au2h3BlDBgQahCRJgz20nMF2bhLXw=;
        b=kkJkV0Ple+RYKiWYGGIICekhuqOsHbeZZBMNOX9wdaVElMJSmlwfeWREYpX0KDwWI6
         ouJtDcRSfZY5LEiycfwEPU+iC2Noen8k/NrFGBcN636y8egLOZI4wOhjiVlSmF2LRlOp
         TVzmTKREj/2fxnq7VY67f/82RZBdddTidIro0BrdGz95dZDDWaN2LmQanPvwEXVHhg6r
         56v+MvttAj1UtkH/1Qko0SmSgmxqDz4z1KL3+PBV1kaappfLy/SUHOIoG1bCtdlmyqcu
         tmF2z4JaB3oYLzj+mHj2dpBiQ6LdCZTByHjbSdrIR8lo3yaxUGfSJ08qrP+7Hi4MXprv
         ZpOw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780052879; x=1780657679; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=K5d31O66j14PfHF0RDLXw35l15NLOx/uF0bU9fTRqGM=;
        b=sa7AOjCwJiqZuXLFr1VoIYH51u5Kw5aPWJkRvNz87FJ5ID2MqUvIpXwJbmpr1wFGjy
         4sBTKQwXj23u14907BUQTbkk7G/x0XbrqmHFZDPXFpIE/XM9mF9sFthc545maSTTHgDb
         IdWQyECg+YPfcO3xrwPUWhLc+RRT0LqIy4y4RLXu1Uj3qHLsKQ7tzqydNsRjQXq7sIDv
         +f3QT5I6eclsC/WwfYjPBPgU0xFTruJ6TishKUxQmPn5wPjaGw8gwA/YVT1jMKdFkIKj
         8tiw8/8OqGI2pzLzp1Y4TxTP0yMhaFuHh0Os4KWd+7vCR2gBmmTu8wo2UD8ry5ZuheJX
         LuZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780052879; x=1780657679;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K5d31O66j14PfHF0RDLXw35l15NLOx/uF0bU9fTRqGM=;
        b=nC7onH60zGUQyWCNzZrxyyeLUYlYGmRWwuKhk9HEKGoew0MB6GkWs9zZbdIXiorwBK
         aMveQu9PH1+haPBx5f0l8E8vah9klUoK7wwaPwHtDFOg20bGUmMMbuLeTZW0Ew+rz0JE
         Ru0AFO152qg0nYKU7RyWZBSSdARf8zXS5z6jA2tQ7b/JpFMg9qxBPnetb2Da1KFO2WMT
         Ll9+GZsSLBmN7bNjcAIFP9KALWOZGkeXtwhtF8/DIe2SkiQvzpPsVXgvCVs/twa+5sKK
         1hlDx3KmyceCRMUOsyc+BZ1NhgJX2dSk2F+Ua37h72byXdc6lIpQN12Z22kCYq1JxwfL
         WaRQ==
X-Forwarded-Encrypted: i=1; AFNElJ8AneMo546yfjCaMuiIt/VeTw9fLPAe8uN49mgsL3+IYxMYoA4IkzyEKs71e3yK9xcu2AtOf6dVzPI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7xEsuKZw4zjPl3DPLOvrOlTBLkIDTZu1Ug/FK7PoznADN6J03
	ECASxznJsBKq7MB49yk3Rpy4UmNNS2KGV0mi/3Vmf3PG7PRFXwdnnjMwC8RWISK6F+tzm/tkrmQ
	1i9ZFR6K3IyW4BQbfquiVBF0ON2exfWcadzXI
X-Gm-Gg: Acq92OEoGBc91uM07FRpLCNcBRK00quR0dYrXlswtaInccqMDi9YPkJFnb1VLyvaWOb
	48NeUtVoDzrPMGCfFfviTCe3SUuDicw2iUZUGqesSyndtfdc+m4ELbIJ0n0RlCvsiKrz4Bq9j4u
	gDmEkV2E3YMTGay+D/Wp/GGtx+bynw9DyZYebfwFImDBTiSPFzK3wyn5VMw2ZBxaQzD39x5PVBo
	Rl6uJLx5SvvHWInLcxKAxI5YjiYCIE9BEB5382V8p10prY1wuRvr4LNiXEeev8E//gE3ujzMoeI
	lN/X/7cVhGsaXp3YuqNO7PnfefvftcjamnH6m65QdaAjPAeMMyd6Y2A+0kxoMYQ9gu8sSB0tf95
	WCMaGD4zP3Nqw1MJ1viocF3TorWsiQZgERxMvvfDSrBU4MVF0EFYv5It5zTKM1ykSdib9CjlLzB
	NrfDIrwXoNNej5eCRq
X-Received: by 2002:adf:ebc1:0:b0:45d:4c30:81a6 with SMTP id
 ffacd0b85a97d-45ef143ddccmr2264813f8f.5.1780052878548; Fri, 29 May 2026
 04:07:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260529101011.3030-1-sozdayvek@gmail.com>
In-Reply-To: <20260529101011.3030-1-sozdayvek@gmail.com>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Fri, 29 May 2026 13:07:46 +0200
X-Gm-Features: AVHnY4K8ZmE4ZUfBhgpJWma5PX7nP709jNwkeVX7rZ5RnjDodXIMTaHd1pof54s
Message-ID: <CALoEA-xak7LiCh4vbK0C+dJ0r5sYpKKKPqz70fmK8oruJ0HUjw@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: ti-ads1015: use devm_pm_runtime_enable() to fix
 probe error path
To: Stepan Ionichev <sozdayvek@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 29 May 2026 at 12:12, Stepan Ionichev <sozdayvek@gmail.com> wrote:
>
> ads1015_probe() calls pm_runtime_enable() and then iio_device_register().
> If iio_device_register() fails the function returns directly, leaving
> runtime PM enabled and autosuspend in use. On subsequent probe/rebind
> the runtime PM tracking complains about an unbalanced enable.
>
> Switch to devm_pm_runtime_enable() so the enable (and the matching
> dont_use_autosuspend) are torn down automatically on probe failure and
> on driver unbind. The manual pm_runtime_disable() and
> pm_runtime_set_suspended() calls in ads1015_remove() are no longer
> needed and are dropped; the devm action runs after .remove() and now
> handles the teardown. While here, convert the dev_err() + return to
> dev_err_probe() to follow current style.
>
> Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>
> ---
>  drivers/iio/adc/ti-ads1015.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
> index c7ffe47449e2..2331e946c519 100644
> --- a/drivers/iio/adc/ti-ads1015.c
> +++ b/drivers/iio/adc/ti-ads1015.c
> @@ -1037,13 +1037,14 @@ static int ads1015_probe(struct i2c_client *client)
>                 return ret;
>         pm_runtime_set_autosuspend_delay(&client->dev, ADS1015_SLEEP_DELAY_MS);
>         pm_runtime_use_autosuspend(&client->dev);
> -       pm_runtime_enable(&client->dev);
> +       ret = devm_pm_runtime_enable(&client->dev);
> +       if (ret)
> +               return ret;
>
>         ret = iio_device_register(indio_dev);
> -       if (ret < 0) {
> -               dev_err(&client->dev, "Failed to register IIO device\n");
> -               return ret;
> -       }
> +       if (ret < 0)
> +               return dev_err_probe(&client->dev, ret,
> +                                    "Failed to register IIO device\n");
>

The pm_runtime stuff seems fine, however not sure why you slipped
this change into the patch - there are a few more instances where
dev_err() can be moved to dev_err_probe(), e.g.

https://elixir.bootlin.com/linux/v7.1-rc5/source/drivers/iio/adc/ti-ads1015.c#L981

-- 
Kind regards

CJD
