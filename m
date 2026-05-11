Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FFBA23AE87;
	Mon, 11 May 2026 14:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778511369; cv=none; b=QFfgiiq+Nu7b/kMgrmQk8REcvnMpQeYyzca5Y01DbLPohoGbDnDuYpNp/uOxUoUOWqK3nDGUfPIR9i58Qc+chHWLHujaDgjGzn0Brg/9fDV5CtD8g/gOJKnoQ79jiKQISTZkeNgGb7t5zVTUaW+U6jt95K34eHjJbU3Kkc1ywu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778511369; c=relaxed/simple;
	bh=jJ5ijwlIRglxcOqJ8DIXyMyhdHeaw/BPl3JlmgNMXHo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tEuCOX5v26y03Vpfy8kOekVcfo+5o3+yYkqUV7YeoWf+U1pGa/sHgX4WoEmhvvLKmsWzJ1JGmzvthQ6HpUry8FvAPThZVCNkLHrpxUK4zW34wfqDQEtTYJ4Fa+95svAE5GCj+wOk6cqKgMJjG2yo93mtTDTIeqEbWVx82EVdZok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QALkYU5g; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QALkYU5g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77820C2BCB0;
	Mon, 11 May 2026 14:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778511369;
	bh=jJ5ijwlIRglxcOqJ8DIXyMyhdHeaw/BPl3JlmgNMXHo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QALkYU5gARm1zY2f9qWnqZxnUzLQ9cUZvQVVZT+pcEYCpSydpKtVKG6prj8iCbqgQ
	 j1npblseyqCa/n68Jy7eLs1FDhOVuqmMH8x/hBZ1uPs/Jbctcex5LcGquMfoZN0dbq
	 MWB4eTpRMBH9C62qfz7gSRFMUe4m96uPRv45w+brXusmodMx7WUQCkXm68Fw9rF3hl
	 ElfFn7z8b9buwTf9UufXBMVueN9u09rwVzPUTs7HstY2dXV1MNziwNcanrcigSWwtk
	 darWtensR4BS7vhWdCgxdII+4MAfv7DjcVcf/4vv/+T453pUH0deM0sdoa0/5/tRzv
	 oMnlDB8z+tGxQ==
Date: Mon, 11 May 2026 15:56:00 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Stepan Ionichev <sozdayvek@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 gregkh@linuxfoundation.org, hcazarim@yahoo.com, joshua.crofts1@gmail.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: trigger: iio-trig-interrupt: use devm_* helpers
Message-ID: <20260511155600.13fc63ab@jic23-huawei>
In-Reply-To: <20260511063229.1433-1-sozdayvek@gmail.com>
References: <20260511060732.7728-1-sozdayvek@gmail.com>
	<20260511063229.1433-1-sozdayvek@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 May 2026 11:32:29 +0500
Stepan Ionichev <sozdayvek@gmail.com> wrote:

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

Silly question for you - how does this driver actually bind on a modern
platform?  That is - how do we get one of these? 


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
> -	unsigned int irq;
> -};
> -
>  static irqreturn_t iio_interrupt_trigger_poll(int irq, void *private)
>  {
>  	iio_trigger_poll(private);
> @@ -27,11 +22,11 @@ static irqreturn_t iio_interrupt_trigger_poll(int irq, void *private)
>  
>  static int iio_interrupt_trigger_probe(struct platform_device *pdev)
>  {
> -	struct iio_interrupt_trigger_info *trig_info;
> +	struct device *dev = &pdev->dev;
>  	struct iio_trigger *trig;
>  	unsigned long irqflags;
>  	struct resource *irq_res;
> -	int irq, ret = 0;
> +	int irq, ret;
>  
>  	irq_res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
>  
> @@ -42,61 +37,20 @@ static int iio_interrupt_trigger_probe(struct platform_device *pdev)
>  
>  	irq = irq_res->start;
>  
> -	trig = iio_trigger_alloc(NULL, "irqtrig%d", irq);
> -	if (!trig) {
> -		ret = -ENOMEM;
> -		goto error_ret;
> -	}
> -
> -	trig_info = kzalloc_obj(*trig_info);
> -	if (!trig_info) {
> -		ret = -ENOMEM;
> -		goto error_free_trigger;
> -	}
> -	iio_trigger_set_drvdata(trig, trig_info);
> -	trig_info->irq = irq;
> -	ret = request_irq(irq, iio_interrupt_trigger_poll,
> -			  irqflags, trig->name, trig);
> -	if (ret) {
> -		dev_err(&pdev->dev,
> -			"request IRQ-%d failed", irq);
> -		goto error_free_trig_info;
> -	}
> +	trig = devm_iio_trigger_alloc(dev, "irqtrig%d", irq);

Passing a parent to the underlying iio_trigger_alloc() is a functional change
that needs to be clearly laid out.  Do that as a precursor patch where you
can then describe the effects that has.  Honestly I can't remember so I'd
like to see some analysis presented before I look at it!


> +	if (!trig)
> +		return -ENOMEM;
>  
> -	ret = iio_trigger_register(trig);
> +	ret = devm_request_irq(dev, irq, iio_interrupt_trigger_poll,
> +			       irqflags, trig->name, trig);
>  	if (ret)
> -		goto error_release_irq;
> -	platform_set_drvdata(pdev, trig);
> -
> -	return 0;
> -
> -/* First clean up the partly allocated trigger */
> -error_release_irq:
> -	free_irq(irq, trig);
> -error_free_trig_info:
> -	kfree(trig_info);
> -error_free_trigger:
> -	iio_trigger_free(trig);
> -error_ret:
> -	return ret;
> -}
> -
> -static void iio_interrupt_trigger_remove(struct platform_device *pdev)
> -{
> -	struct iio_trigger *trig;
> -	struct iio_interrupt_trigger_info *trig_info;
> +		return ret;
>  
> -	trig = platform_get_drvdata(pdev);
> -	trig_info = iio_trigger_get_drvdata(trig);
> -	iio_trigger_unregister(trig);
> -	free_irq(trig_info->irq, trig);
> -	kfree(trig_info);
> -	iio_trigger_free(trig);
> +	return devm_iio_trigger_register(dev, trig);
>  }
>  
>  static struct platform_driver iio_interrupt_trigger_driver = {
>  	.probe = iio_interrupt_trigger_probe,
> -	.remove = iio_interrupt_trigger_remove,
>  	.driver = {
>  		.name = "iio_interrupt_trigger",
>  	},

