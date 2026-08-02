Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC6F2C11CA
	for <linux-iio@vger.kernel.org>; Sun,  2 Aug 2026 15:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785685205; cv=none; b=MVVFYZKzZeZlk02mlxWibO0eU7pFfY5FXFeytYZLvsf7QcB/vj6Y8cBVr1cLd1fvEka58TqoH3riV1Z8D9UtGkJyhq32/ajVgzvSYo2y6hCdX60r7Nn2oMHHKA7lXsR0aDPPwBketviy6MmRjLsZqFCzl8e3ll+LlniQhglzaDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785685205; c=relaxed/simple;
	bh=S9GF3h7gmhd8ieK4IJPj1yC65IXD+OHH4Bv/vHTquF8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DHMNDnhp7nLccrJMnvt2aWnNb7h0ol/4TXXbicnczfWJJlC6qsd6Bfgo1sHzMzc6Oba7FSELwxpZaE3NBy3DyWf1S5/FbTTgoLO6o9jVc+SfmlqMVcq1mf9xWvobnOQatjwiQ9AXSrIyZbj4aBDhkNh3OnCV7UIAvfdnPEttwLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=mpo2VKWV; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="mpo2VKWV"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7eb545db3afso1746752a34.0
        for <linux-iio@vger.kernel.org>; Sun, 02 Aug 2026 08:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1785685201; x=1786290001; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TVSsAwcRy1uonwMzmFb3HAht5GF4K+y7gUHhjcWsEHU=;
        b=mpo2VKWV+sawBuQQPUUpKXkFCXL5ZEzgCNPP9Ml3BokUWH8BFfSf7QqevUCAF9dAw1
         pjD2QdryxIKYCL/MYfhWgrlS1ZGqEs/5Kc9KeNFyGkFF/pPCFu/F92OB62u8C7Jnq4QJ
         lxqAhtRLPaWlVlRsuMSOHonmsvcxbjb/rcSQ3E+cq1pjPUp8sF0D4aYUBgq2Pv80tmtT
         4eSq0wQ7ZiKAz+zGH15w5Nk4DOZVaDmfMEKowJAQlh03sAMdrA3+/viOUecepkiBVb08
         +IKVoci8zyjrjKlsxs4VJqILuWqPNEF2tNE4S1ky18EN5rnN36lHpwxConPtOYHpEGCe
         zVhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785685201; x=1786290001;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TVSsAwcRy1uonwMzmFb3HAht5GF4K+y7gUHhjcWsEHU=;
        b=Kll+occWl8lahpwjLSDQ70rf1WVujRCPTTFOgl/YLyV5wUVYBqoKikc7DUsGUy8rDN
         rSRtvWICceeaNSXmUJ/FyWIhmIivKK5oHaVmNFfBSft+Jf52P+em4eFoN/BKlqmRJFkn
         oLbyAWK3U2kjLWAP9CfaRI0zqEGOwYFbKLEX2/7KDH7MbXt8Vcz+hrswiEE/q2FYW0Ie
         j+byjmtZDg9xamF8MkLsriOebqGekiXM9d/HAck82foFSTlwtpvbsIbdM9OlOeJElVG0
         YUT+4bMWANAJ58W318Qvsq7a67TwyWYYUD2KzCQnXyJM4UaM2PDMxonOjcBjUTDnHrwB
         dVaA==
X-Forwarded-Encrypted: i=1; AHgh+Rq4FztcPY6LC418JbBazsizIgJ7kc4LhIRNqxqUVKm7n6MsbN7AKHrkj6HnQfZH+EhcONYGxsj0toQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG+HpA6ck2FASOkI/Zi08yiaWHuxr3q3WAdd+omCi27EQQXdfV
	eOKBpLyBNWzLhgOAMi4oN5sjRgvBFYqX17Z5WzySIKkllsBvgp9zuaZ1UGyF1RxuiLE=
X-Gm-Gg: AR+sD126WGIYZx5IACqVCdpO33uLKoT3ongym0uKfUiPM4RColaNAvfYmBJTPR3fRJn
	JL6yHmmYqDXxbQdH4DXM0Z1yHXFM+rtiSakAe9fe6XZ+f53g6K1ie28Wx78n/7EFtxxQD3o78Mt
	XsbJjMju7dqmHjU/uEG9Jm2+FjVtorT3SzV+koQO18NxjITI3uhL1/K7yPljgOle8EgHk+Q4yaw
	HSeaalH2jopveAzG6XHKBtOqiKAABKZ1ZSJvxlgmrA2EjFd1s6ppYzjiq/xHs3TTz68p7ZIxq8J
	ssiM5HkNrEt6X7ZmIgrbZDKgsRDkEPiUVKnxyenJo7sImubLj6kMv2bIUB/SAhW1mWRRLzP6bd0
	bT7xKkSIRUVSK4tO12y2hBZN2egrfBWl2yBCwc3Q5XFDAOaJ6nnf1KDfpp6MTgfF7UfS1ZSGPPm
	JDc5iky5LRLoEv5i8hGEe/QAMOyJnVqOsehTaR6zqqAOrX47PcxLGjQE1pO4BEIhWhHEYQdTX3E
	21qdSyKRdmdgBp3Yb4hQJr+ttrfKDdW46bYgoQ=
X-Received: by 2002:a05:6830:700c:b0:7df:5fc:3fd5 with SMTP id 46e09a7af769-7f196b97f19mr12557105a34.1.1785685200962;
        Sun, 02 Aug 2026 08:40:00 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:5487:2b6e:1057:d3d3? ([2600:8803:e7e4:500:5487:2b6e:1057:d3d3])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f18ed3c81fsm5342440a34.5.2026.08.02.08.39.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Aug 2026 08:39:59 -0700 (PDT)
Message-ID: <750f615a-c00f-4e98-9bcf-8fa8704acfba@baylibre.com>
Date: Sun, 2 Aug 2026 10:39:58 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: adc: xilinx-xadc: free IRQ before cancelling the
 unmask worker on unbind
To: Fan Wu <fanwu01@zju.edu.cn>, jic23@kernel.org
Cc: nuno.sa@analog.com, michal.simek@amd.com, bgolaszewski@baylibre.com,
 DileepKumar.Nagavarapu@amd.com, linux-iio@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260802082851.433476-1-fanwu01@zju.edu.cn>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260802082851.433476-1-fanwu01@zju.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/2/26 3:28 AM, Fan Wu wrote:
> The ZYNQ XADC interrupt handler xadc_zynq_interrupt_handler() arms the
> zynq_unmask_work delayed work via schedule_delayed_work() every time an
> alarm condition is observed, and that worker re-arms itself for as long
> as the alarm stays asserted.
> 
> In xadc_probe() the IRQ is requested with devm_request_irq() before the
> devm_add_action_or_reset() that registers xadc_cancel_delayed_work().
> Because devres release runs in LIFO order, on unbind the delayed work is
> cancelled before the IRQ is freed. The IRQ is still live at that point,
> so a pending alarm can make the handler run once more and re-arm
> zynq_unmask_work after it has been cancelled; that instance then runs
> after the xadc structure that embeds zynq_unmask_work has been freed, a
> use-after-free in xadc_zynq_unmask_worker().
> 
> Register the cancel-work devm action before requesting the IRQ so devres
> LIFO teardown frees (and synchronizes) the IRQ first, then cancels the
> delayed work. After free_irq() the handler can no longer re-arm the
> work, and the subsequent cancel_delayed_work_sync() drains any instance
> armed just before the IRQ was torn down.
> 
> This issue was found by an in-house static analysis tool.
> 
> Fixes: 2a9685d1a3b7 ("iio: adc: xilinx: use more devres helpers and remove remove()")
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:gpt-5.6
> Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
> ---
> 
>  drivers/iio/adc/xilinx-xadc-core.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
> --- a/drivers/iio/adc/xilinx-xadc-core.c
> +++ b/drivers/iio/adc/xilinx-xadc-core.c
> @@ -1395,13 +1395,16 @@ static int xadc_probe(struct platform_device *pdev)
>  	}
> 
>  	if (irq > 0) {
> -		ret = devm_request_irq(dev, irq, xadc->ops->interrupt_handler,
> -				       0, dev_name(dev), indio_dev);
> +		/* devm LIFO: register the cancel-work action before the IRQ,
> +		 * so unbind frees the IRQ first, then drains the work.
> +		 */
> +		ret = devm_add_action_or_reset(dev, xadc_cancel_delayed_work,
> +					       &xadc->zynq_unmask_work);
>  		if (ret)
>  			return ret;
> 
> -		ret = devm_add_action_or_reset(dev, xadc_cancel_delayed_work,
> -					       &xadc->zynq_unmask_work);
> +		ret = devm_request_irq(dev, irq, xadc->ops->interrupt_handler,
> +				       0, dev_name(dev), indio_dev);
>  		if (ret)
>  			return ret;
>  	}
> --
> 2.43.0
> 

Makes sense.

Reviewed-by: David Lechner <dlechner@baylibre.com>

