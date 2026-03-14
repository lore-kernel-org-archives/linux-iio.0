Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF5F23EA8A
	for <linux-iio@vger.kernel.org>; Sat, 14 Mar 2026 20:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773520265; cv=none; b=Tbk2xD0n8oBleJj5GiogvYeZfjICfBYG9g/bLGIObGbs1pIDawDnahlvZ/wwCNX8X3ktdlmHzNReGRNHR0gIBCJaUE6ZyNzCx/M8Nawfsu2lrvKLVhwkjKNuSObcMhDxbAvPmu7ajJ46ARvWApnNkBbZrTaIPUJTfqrIhDMQH9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773520265; c=relaxed/simple;
	bh=+qH3lrpB2RQfA+E/p1AQdHkXdzql0AKcXJfHXIJepU8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FIG1RlLsI6FvEDK1xhpSDzhQ82i95UvcuAVbBjoE7wYUuoZ99xgBfo2OOd8j2bqjPNpYsxO2USB8oKyyWxDEcS3zRwCFuH6RDnJEPZU37fGuvKWCd1VD3GVtme8SpwFM86/B8unChBRvk9+aMepGfCrcg8Ylxv4ToC8woBwIFTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=AMS1l6bA; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="AMS1l6bA"
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-67bb17938d5so2379554eaf.1
        for <linux-iio@vger.kernel.org>; Sat, 14 Mar 2026 13:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773520261; x=1774125061; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RdoLivEcE4SPv0KkYiZWBY6QrKfvLCK3k2ZW751a76o=;
        b=AMS1l6bAozj7hviDi28TxMxhtuQ4WtTEcQtmf1O1DCGDDARGjmZuF9nd0IpcrCZL4U
         f+ebzqPtAdVoO23xrn5cTk7221tqUndECN0gKjl8I1fAAsrIa78NTLMrBiDPh2s/hXAk
         uF2G2MXipf1+ZHAew3Er7Gr9sj2zg3NYXBHOsi2W5nwC58iSUagXi6NJMegXFFXouGpN
         iQUDCghx/uY4Mz8MEPcWIAENJle2oNv+8LWqcPnEgP9CYDrSvErv6j4SHM1WWgIgaDyT
         DhDeZh7Dtufh8V3Ob3xYEFByZd1QL+7M7N/2bgyL7mw/gV/ABDmlzT+U2JYIjVsuD6Hm
         WStQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773520261; x=1774125061;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RdoLivEcE4SPv0KkYiZWBY6QrKfvLCK3k2ZW751a76o=;
        b=QDBc/hd0yJALbD3gIZvXnKbrHJXXXjLRL93VFbZ5TxSCjJOwnvJwKbkWSV7j/5uLaw
         FZ0uqNAarcwhp9jnIrTh3PF3KTsHdjFdwgve3FQs6yYA3sht//MDOYoOV9MM29GgxjCI
         GtvsjO8pigeiSNt26MTPN4dL6pO4dCWy9/9bwOKs8GjGZ+1P2m0DU2LWtfXN/QQ86OMW
         8HQCrmk9LSCEBQP8VR5PoyHoheMtTQXWm8h/AXAqScAW0tlZRG2dDVLG8aB249BWWRHZ
         qtxmoQ6h4gcWOe9eunPhKgfKyeM95VTLjZfnQuk9ye6/gsABwpJFi8XRHDMy6qrk7WCC
         QxtA==
X-Forwarded-Encrypted: i=1; AJvYcCViGCQYkTfPXV3f1+n8YUdwozwVFj166ncf83BvGQurNVrj5Cny8onhGTOEv5wS9aijEje8WW5MNVM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzU0gDhLOeKlyfd5Z5fD718xfgXwFv/09Vt2SP1Qd+d9R0ti7ev
	yyFRaWLPuAyHOWI11EGkJTFtZEh037G0SfSrAW2/xwIRlRkyioNjyKcYX3646TBOd+c=
X-Gm-Gg: ATEYQzzcxq7LO76NaMD5kEYyxP4vUMoRfIAm3+wBhLi5pC00HlIgLHZOC0YaW3DLEve
	8bRmJccuqJnQsc/ci1UZxgIWVg2iki333QTP1GthqHZ2c8rV/lge/Tlj7Pn6szFv6Ltg5zACx6A
	O2/MqZBP2JgtxnPnEv6cxO0BFeL/eB7JOViKkNiz7CuLz6xqZynrkpw3eqLZmf/uo0DTBV4QF5d
	L9q8WBxkZKbcZ2+y9CIf63wM3eCPkRvDzMxMDjMHAtCTEcg7FB72voIuerddVixXx5mmLEs296F
	emC0KXxBHhbno2RTGGE+ldFBPeQolPFDLatA14ZF6rEB5IP+S8BmGOl0JwleE1E6/LLiwDX3HxI
	St5TQPNNJtA4fYuyJABLkS5r9IwYkJ+bzd+qB3LQthonMA3BkVx/3iavQHAucI6cLKsb5lFRDnU
	MwFQ79m6zNPqUxxbbQJC5JTU/2bmwO5s0oPzrwzp7R0tFc7/2z7f20yHBtG1H8tWAmFiHbr9FR8
	gXQwYvkYf8y
X-Received: by 2002:a05:6820:98f:b0:662:b70c:a414 with SMTP id 006d021491bc7-67bda98ce05mr5616978eaf.14.1773520261570;
        Sat, 14 Mar 2026 13:31:01 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:14a9:db6c:e65a:4287? ([2600:8803:e7e4:500:14a9:db6c:e65a:4287])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-67bc8efa80esm7383958eaf.2.2026.03.14.13.30.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Mar 2026 13:31:01 -0700 (PDT)
Message-ID: <8bb22b8b-7229-4942-80f1-6eccf9f26a8c@baylibre.com>
Date: Sat, 14 Mar 2026 15:30:59 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] iio: st_sensors: drop temporary kmalloc buffer and
 reuse buffer_data
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>, jic23@kernel.org,
 nuno.sa@analog.com, andy@kernel.org
Cc: kees@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260312063424.3846945-1-sanjayembedded@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260312063424.3846945-1-sanjayembedded@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/12/26 1:34 AM, Sanjay Chitroda wrote:
> From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> 
> Replace the per-call kmalloc() scratch buffer with the statically allocated

"statically allocated" is a bit misleading. It is just an existing buffer
in the private driver data (dynamically allocated during probe). 

> buffer_data[] field present in struct st_sensor_data. The existing buffer
> is DMA-aligned and sufficiently sized for all channel widths, so using it
> avoids unnecessary dynamic memory allocation on each read.
> 
> This simplifies the code, removes redundant allocation and cleanup.
> No functional change intended.
> 
> Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> ---
Reviewed-by: David Lechner <dlechner@baylibre.com>

