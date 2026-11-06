Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793965080;
	b=vJajcvLxFcYNPA0QPaoJ6NvggNkSXcKZAqtSCy4nZBwPvPZTdraajaRzqEjbo4zBRGyZ
	 1kGCh9sUOqiQu6s3VvzxLlwfbaAwvIMhMP7OSDQW3Xh2BRWrHRQ18iV3CLLeu5hYONrFh
	 GMSw6A3PdQh31K/iLC/mJ1NkDwYxW8LIJ/qjKExo205DFiSDuN86bXeOSyuikyuKUxt24
	 zDgsmFsXs1My7lv4cg//N8EfwN4d9TCnCQEV8rhKnhEI3ArUN4tmpXLuyAIsByQ0J+7fI
	 ROLc6iDmg2rh9VIRKDP4zuvHKB38sTp0Z1Tan7DmbFXxO1vdsygz1SM24XM4h8quTWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793965080;
	h=DMARC-Filter:Received:From:To:Cc:Subject:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:MIME-Version:Date:Message-ID:
	 X-CM-TRANSID:X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=2r9tQ08CWM02Vgi5/iQoQ9ITr8b5Od+1vizkEuslVtI=;
	b=eicb4e7o4gIWWjr1FHX1B4LMzFDDak6GhR9HJY5wwf8qCUY9UW+MZgQWfVQdOjmoVZ9W
	 TmkUxu4u/s4wgrsAoBeO9yXnMVznbWlfonnsF5lpchc91WQbmc3hLU0aYU28nqaaUkpnH
	 RvCxs7b4Py3inl3t1HIGHKZSQx7WjP1wvizEX+4loc3MLyDi6pKfNf0kNvks57e1E+z/c
	 2SXbFGnfHRbuQiKFvmClLFP+q/xmesZVSZsCxm4VLy/0Ykj9oe8copdL1399n94yuP9dW
	 FcIm/8xj8esmfsxveYdWxoJsYPBbHz7lUjt481HwzxyfsY1s5KAqbxL3kk9vR6nitjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.81
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C26606A32C;
	Fri,  6 Nov 2026 11:37:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7C26606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [172.100.0.8] (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowACnro8RvO1qkOpsAA--.21855S2;
	Fri, 06 Nov 2026 19:37:53 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Jonathan Cameron <jic23@kernel.org>
Cc: andy@kernel.org, dlechner@baylibre.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, nuno.sa@analog.com, petre.rodan@subdimension.ro
Subject: Re: [PATCH] iio: accel: bma220: Fix trigger reference leak in
 bma220_common_probe()
In-Reply-To: <20260917011518.297868ca@jic23-hlaptop>
References: <20260916160823.2082283-1-vulab@iscas.ac.cn>
 <20260917011518.297868ca@jic23-hlaptop>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Fri, 06 Nov 2026 11:38:03 -0000
Message-ID: <179396508376.2291875.4312877838122457985@iscas.ac.cn>
X-CM-TRANSID:rQCowACnro8RvO1qkOpsAA--.21855S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Jw1kJFyxZw1Utr47JryrZwb_yoWDAFg_WF
	ZYkryakw18uFZ7Kw47ta1Yqr47XFW2kry5Cry8u3ZIg348CFs7GFWq9r98Xr1agFWUGrn5
	WF15tw4Ykr129jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbxkYjsxI4VWkKwAYFVCjjxCrM7CY07I20VC2zVCF04k26cxKx2IY
	s7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4
	kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_
	Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
	xl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVWxJr0_GcWlOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxAI
	w28IcVCjz48v1sIEY20_Gr43Wr1UJr1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1D
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8
	JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU5
	FksPUUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRMDA2rtky+YaQABsR

Hi Jonathan,

I am sorry for the very late reply and for the extra review work caused by
sending many similar patches without first waiting for feedback.

I understand that mixing devm-managed resources with manual trigger
cleanup is not an acceptable solution here. A broader solution needs to
account for runtime trigger changes from userspace and distinguish the
references that managed cleanup should release.

Please disregard this patch; I will not resend this approach as v2.

Thank you for explaining the lifetime issues and how this work should be
submitted. This has been an important lesson for me. I will personally
review and respond to the remaining feedback one item at a time, and I
will keep future submissions within my capacity to follow up promptly.

For transparency, we use static analysis tools to identify candidates,
then DeepSeek and GPT-6.1 Sol to assist with auditing and preparing fixes.
I am responsible for verifying the findings and changes before submission.

Best regards,
Wentao

