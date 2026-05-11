Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB693EF0DD
	for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 13:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778507652; cv=pass; b=sTCL1jOa96loIZsyVmt0Pt/tXw4TM4PQS6AMZiD2c1vZ4DcKkfWBt/TwLDkHKLLC+S8HHceBfYfH0QDvBoDzb5ack1HIbpt0RtbLX1pQaw7UA4otSrL61B50XJ+rseZXt7qh7WFNiaJordfYY47vbmIULbn3HwBHLCoMO1MXAH4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778507652; c=relaxed/simple;
	bh=42H6HZJrU1Te8co+4NeFhbcPQ+8Svglh4zPqu5tVHGs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M2yqi2K00hcw2MAqzl8fTBqs2ldtJLb9hOAeYiVpJw3J6A6mWokj9jujJ5qU0J8WObUN3r/+5FZK/YkKlJYeD7TlkaeFvynBJizy+B5Sua7N5pOYqXioygop1FHjWg+Z3HFsmaK59moBO83exAGwF5g7EiaYRneiiLitc4UhiZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pf2ohISB; arc=pass smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pf2ohISB"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-43d77f6092eso2694465f8f.2
        for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 06:54:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778507650; cv=none;
        d=google.com; s=arc-20240605;
        b=EBy1iFIGVPKIphRuTxvN0v/j5Z3sPYBX6TcK98ZSZCQfLrWPq2uhCQtn4NkkbfuXmA
         sjMHs8YhYETwSAk8wtxNMRpGiBKq3EUIGTFzs4wwZX/vWvFXUUzLesUhzrczSD9avJsG
         N1zVF+xBw2qVtL+0MkzIWh1ciqT/MQ7oK+FuHH8sdsrR7UVIve0hAjIPRHc/1BAtAVSx
         tXfCq8+7/AX4F1xbmSrz/nMUSlomI6UBT4fji1GsKf++qsnMuW/OzXMbvsVXkiF/tfqQ
         EihIFo+/iRR0G6YhL8pcinBoR7y23EUJeCY8HYHJPl5UWQUDOM+Rb+OEJx9xYt52vtT4
         rAsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=cdCgUPEodpayW/dLsANeCRmEELdWqgpNeGDEfisayYI=;
        fh=PTvoYOXwmWbrX+mD/hDMjXxBTGAbKX1IWcvWwJ/mXhM=;
        b=jMEYZod84Rt5AOlnD9xcYTigUFVffiLE0sP2Zz8jtRVWPJSl+5B7BT+y4XYSfUJ67x
         wWRnHfJuJ/iKRn1S9pyf3e1ytcqIL4+eBgPKKZ7rHU0+cilwbfBlz+PWXdBjCu8iOvkL
         w+ptA7fMn+MZvpup/92UlNYI9jKNAvh5bef9OlraTGPkWwumYW+RTvWjA4aY+SUCP6Kn
         YsbeTRncAN6PFcVXuJYFHdZeXIccpGNsMRblr3YrPC1z6MqeyLsixbuqrRTTjatxVQ/z
         5kO+wUlMXMGuWQ4yhg7J/bslpvlXKBNqOa3YScGqQ/xEQO7cW5/vr5uVPdQpTQGAxPWx
         PhJg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778507650; x=1779112450; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cdCgUPEodpayW/dLsANeCRmEELdWqgpNeGDEfisayYI=;
        b=Pf2ohISB8vF+hL7Hj3cyaibLAkfek4njNZhlLaIYovpW1QuJb3RXLjSvyIlsrTgVQV
         LixDdwiTUNxkMmf88WdHFMeeEN8CLHozbecProPAjmSK0OsWKSacSwjulY+EQovE+3pg
         yK4x/vPYUgmc7d2KcWFvyCsR5nPUAgvw+x6phalbfxY6XZx15SgUtwBbbvE/Rc9FUzTq
         OzM8SacqPFMiwyaYJsOgZE9xR+Ci+0cpbqR3k45ThqcsTfY+1xcXq1iMsaHQ1k6TG6ZL
         jJWpneMw8NwJH4UMMTTc9jdz6IGAlRAR5c7ZqkXkEYupoJhojPRXroSuFm2b+ux74BNZ
         Y06A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778507650; x=1779112450;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cdCgUPEodpayW/dLsANeCRmEELdWqgpNeGDEfisayYI=;
        b=KURgARUWQJb7Fl6bwwuhfT+ZK3IWdkjtT/bbom2O7ltPtsBZCjP8Vh+SiTG5wbLOIr
         rLcHcizA6imaUNtbte/J65owmZ8FIw4T6decexmzyI62Brd03gJZ/pTyb3+/+1VOWMGD
         IVGON6A8y02idaD3qtgpxCY+fgFPcAH5Xoyve4/YnlYN44lezXsJJJGWOnbXN5azdITN
         CEhYj+8KZVfqGCm7obL8W4pZhgMDnRxuLr/c8xRLSs3ph03h+hZO2eA6UEZCwca39BQW
         1fp8pR6o/acSHkc+Y3XTti9+ILoPZcYu/HfErovd6f2yWZP9oasvxQEjx9UMNh4j57et
         /4cg==
X-Forwarded-Encrypted: i=1; AFNElJ8r/FJpW/50xig1hC2UIUhtnq4W429g4+YTnBWZHn/jufk8YY+3wV6SsY1cV7C1R6CASMHggS5SxJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1UFxAU960CsvkYLNz1xSAiaUrX1a02mVNs448xic3uxmRBXuu
	GgaLA+iKd4QDydH97kYilT8MWSNSQ25ZItf3gtVg8rihNGXQtrVtiA6VTfz2mJ+2PslOSrxGvMm
	/q3FrOAeSyQyRlo5lBAEm7rZrSvhL0vI=
X-Gm-Gg: Acq92OHbl/dx2Px0wCbmHDgtfwvLr5jFzUr1rBR+m28Rgno5PTrrRmEkNfG+b1LHyvf
	nKuMuOx0HgT6UI0l5k6bTxdUDUFxwO097ZHKnANxwErGvAHFXdF0b11eHPk10gMmT5pwGXDMKFd
	lFEDVXphkoRRjXxcFiztXDVlLD8pOu51q5Dc8O9O8d6drFSORLYv8af38x5+y++qiszR4/jKDdM
	QvkSYQN9UMjZQfmFuNNavJD5BYWmWZapUZo+Tu8+9PTr3qAcu2yuf9WUZOqs4rkckHSvPTqELDc
	0Na1HwYk+JrDnmJSGhH3xFbUo2rYhJoDr7GMytaZYW3g7G5lcV+fjj+z8gr+yPV1jpqbt4590YH
	24rw+QCcs8U0ziwBUJjitM5LLLrHMJdI2UGB+cUBo3QE+mq6spjzQzHX4q413aWXZ2wblsrhacw
	MuOhfvIKLX+Gn9KHTy
X-Received: by 2002:a05:6000:24c9:b0:43f:dc54:9493 with SMTP id
 ffacd0b85a97d-4515c575364mr39634424f8f.21.1778507649032; Mon, 11 May 2026
 06:54:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511060732.7728-1-sozdayvek@gmail.com> <20260511063229.1433-1-sozdayvek@gmail.com>
In-Reply-To: <20260511063229.1433-1-sozdayvek@gmail.com>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Mon, 11 May 2026 15:53:57 +0200
X-Gm-Features: AVHnY4Lb0rMawjs0RYrL4t87EKwHJXTuCE6Q6gM4CW_MBjGy0nCBqFZq8haUNnM
Message-ID: <CALoEA-yn6zYOcBPnMzkuq5sc9izth+QtJ5YbtdPa8L7zTyMh5Q@mail.gmail.com>
Subject: Re: [PATCH v2] iio: trigger: iio-trig-interrupt: use devm_* helpers
To: Stepan Ionichev <sozdayvek@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, gregkh@linuxfoundation.org, hcazarim@yahoo.com, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 11 May 2026 at 15:47, Stepan Ionichev <sozdayvek@gmail.com> wrote:
>
> Convert to devm_iio_trigger_alloc(), devm_request_irq() and
> devm_iio_trigger_register(). The driver-managed lifecycle removes
> the manual error-cleanup ladder in probe and the entire .remove()
> callback.
>
> Drop the now-unused iio_interrupt_trigger_info structure: its
> only purpose was to hold the IRQ number for the manual free_irq()
> call in .remove(), which is no longer needed. The matching
> linux/slab.h include is also dropped.
>
> Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>

I know they might be trivial changes, but please slow down when sending
new versions - I didn't even finish writing a follow up message to you and
already got a new version in my inbox. Ideally wait at least 24 hours before
sending, thanks.

(FYI Stepan, you will receive this message twice as I initially only sent it
to you).

--
Kind regards

CJD

On Mon, 11 May 2026 at 15:47, Stepan Ionichev <sozdayvek@gmail.com> wrote:
>
> Convert to devm_iio_trigger_alloc(), devm_request_irq() and
> devm_iio_trigger_register(). The driver-managed lifecycle removes
> the manual error-cleanup ladder in probe and the entire .remove()
> callback.
>
> Drop the now-unused iio_interrupt_trigger_info structure: its
> only purpose was to hold the IRQ number for the manual free_irq()
> call in .remove(), which is no longer needed. The matching
> linux/slab.h include is also dropped.
>
> Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>
> ---
> v2:
> - Drop the dev_err() call after devm_request_irq(); really_probe()
>   in the driver core already logs probe failures, so the message
>   would be duplicate (per Andy)
> - Use a local struct device *dev = &pdev->dev (per Joshua)
> - Drop the "No functional change" claim from the commit message;
>   the resource lifecycle model changes (per Joshua)
> - Use .remove() function notation in the commit message (per Andy)
>
>  drivers/iio/trigger/iio-trig-interrupt.c | 64 ++++--------------------
>  1 file changed, 9 insertions(+), 55 deletions(-)
>
> diff --git a/drivers/iio/trigger/iio-trig-interrupt.c b/drivers/iio/trigger/iio-trig-interrupt.c
> index a100c2e3a..ddd80ff82 100644
> --- a/drivers/iio/trigger/iio-trig-interrupt.c
> +++ b/drivers/iio/trigger/iio-trig-interrupt.c
> @@ -9,16 +9,11 @@
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
>  #include <linux/interrupt.h>
> -#include <linux/slab.h>
>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/trigger.h>
>
>
> -struct iio_interrupt_trigger_info {
> -       unsigned int irq;
> -};
> -
>  static irqreturn_t iio_interrupt_trigger_poll(int irq, void *private)
>  {
>         iio_trigger_poll(private);
> @@ -27,11 +22,11 @@ static irqreturn_t iio_interrupt_trigger_poll(int irq, void *private)
>
>  static int iio_interrupt_trigger_probe(struct platform_device *pdev)
>  {
> -       struct iio_interrupt_trigger_info *trig_info;
> +       struct device *dev = &pdev->dev;
>         struct iio_trigger *trig;
>         unsigned long irqflags;
>         struct resource *irq_res;
> -       int irq, ret = 0;
> +       int irq, ret;
>
>         irq_res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
>
> @@ -42,61 +37,20 @@ static int iio_interrupt_trigger_probe(struct platform_device *pdev)
>
>         irq = irq_res->start;
>
> -       trig = iio_trigger_alloc(NULL, "irqtrig%d", irq);
> -       if (!trig) {
> -               ret = -ENOMEM;
> -               goto error_ret;
> -       }
> -
> -       trig_info = kzalloc_obj(*trig_info);
> -       if (!trig_info) {
> -               ret = -ENOMEM;
> -               goto error_free_trigger;
> -       }
> -       iio_trigger_set_drvdata(trig, trig_info);
> -       trig_info->irq = irq;
> -       ret = request_irq(irq, iio_interrupt_trigger_poll,
> -                         irqflags, trig->name, trig);
> -       if (ret) {
> -               dev_err(&pdev->dev,
> -                       "request IRQ-%d failed", irq);
> -               goto error_free_trig_info;
> -       }
> +       trig = devm_iio_trigger_alloc(dev, "irqtrig%d", irq);
> +       if (!trig)
> +               return -ENOMEM;
>
> -       ret = iio_trigger_register(trig);
> +       ret = devm_request_irq(dev, irq, iio_interrupt_trigger_poll,
> +                              irqflags, trig->name, trig);
>         if (ret)
> -               goto error_release_irq;
> -       platform_set_drvdata(pdev, trig);
> -
> -       return 0;
> -
> -/* First clean up the partly allocated trigger */
> -error_release_irq:
> -       free_irq(irq, trig);
> -error_free_trig_info:
> -       kfree(trig_info);
> -error_free_trigger:
> -       iio_trigger_free(trig);
> -error_ret:
> -       return ret;
> -}
> -
> -static void iio_interrupt_trigger_remove(struct platform_device *pdev)
> -{
> -       struct iio_trigger *trig;
> -       struct iio_interrupt_trigger_info *trig_info;
> +               return ret;
>
> -       trig = platform_get_drvdata(pdev);
> -       trig_info = iio_trigger_get_drvdata(trig);
> -       iio_trigger_unregister(trig);
> -       free_irq(trig_info->irq, trig);
> -       kfree(trig_info);
> -       iio_trigger_free(trig);
> +       return devm_iio_trigger_register(dev, trig);
>  }
>
>  static struct platform_driver iio_interrupt_trigger_driver = {
>         .probe = iio_interrupt_trigger_probe,
> -       .remove = iio_interrupt_trigger_remove,
>         .driver = {
>                 .name = "iio_interrupt_trigger",
>         },
> --
> 2.43.0
>
