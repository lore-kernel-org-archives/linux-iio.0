Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A7C374759
	for <linux-iio@vger.kernel.org>; Fri,  1 May 2026 08:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777625923; cv=none; b=njpa9Raja22vrz1oGWZsuloAtCQoOPGUldL/lrSJ3GBysl20jwkKZxB9j9Bal09bts6HbsoZu8wXfv7/4QYobVg5CqBUS9HsqDpXx3B47YdM4FsTKa4xZaiyibq1MygYWAYVFkqCXXmOX5cfRpppILVF2KP1p3cdYrhQDPwx11Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777625923; c=relaxed/simple;
	bh=iP5j3TNhso9F21ISpAVulRxhP0iRJaLM6i5Xqf81RQQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PlepRUfwUCd1izAohqhSgfzK4R+gdjGs1LbC9jK9iMXNM7iF2BoFUkUS85f12IglI+jU4YHZKsEtB/XhVtc53GszTiZ01KjaTeC7BXKYqRX513NsMxzURgmrUfgh7Ou4LLK6JkXa7SBf1g1wKLk1wkr4kn44CvYH+zuaJn2B3uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b4/p4mbx; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b4/p4mbx"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-48984d29fe3so25377375e9.0
        for <linux-iio@vger.kernel.org>; Fri, 01 May 2026 01:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777625920; x=1778230720; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rRJX+aih37wROaBQRiyVCIsPFiYyovD0WnOzDuvDLr8=;
        b=b4/p4mbxWh7IivSFs87SK7SdGIMoY7Jpj5ebOa3ljA1fhpRyD4j2ORhWhQKypMcxNQ
         c6fDsIH7VAUYmQxznxzOl7EST5tot5bchzR9DfVI34MmDcH/Smu0etVUQ1nIhQBGlzjw
         xWPO2EFAP21M5zDDz40Nq2BQNYMXM0cMtceF+bihdkVgbr7U0aaZzjCcfCDGkJrgUmhf
         1h5tLu9FZyPEifl7Fz/U3XtUBQdeos9AwHp0DcSIaVGjoaj4WV+SwT5IEKtQXLNx6709
         Mqv9MUh8ikhBgIpjs8eYMDI3NALAIfy2JatSFCCs1Zx7+NUtQx9+vH5IQf92lJbuudFs
         VMHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777625921; x=1778230721;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rRJX+aih37wROaBQRiyVCIsPFiYyovD0WnOzDuvDLr8=;
        b=AUTNckWiPrPs6ojFKwaF/eYh7EvSt1BEcT8Lfb2qzOQhjayrCIHdB/ru1SdrFDSbcu
         rfQveVGMpxspfhVVTwPcoJUvKvO4YmmDozktzI9GlphpzGVxgSwYUFmxzk0UIrGb7Kqo
         CdwaZ7XN0AgJ5CiPXxk5q0HC13ZCjt+7wgkI2r0nErU0org6bxeruZfEQHfQCOAPd+Gu
         m2WulxmgCO//7X9/U1AvLR67yXU1P7wmPyagusR+dphyK9XzRszZsc6F9IA8RfQg33RO
         6Qfu9c1zbgxeyH9SRIxqatMiyBQvz5TdDpNzYexA/uYwExFoNp8Hw/pGghxoAyxCQzLM
         d1qw==
X-Gm-Message-State: AOJu0Yw6qgugOw7eNs+nLvQWrkl3m9BV5HOxxokcLxxAtHiw+JbKiK1o
	wUNRg60qltgd5CMRDDhxgj0jwqlz8ZqL91Do9G9j+CYP5Vu/0RZMXzP2nnYlnQ==
X-Gm-Gg: AeBDiesBGB2kNbk+dGBBBUk+qtXFdMiyU3xsGKpSY7W6dlTMduTE9s+fAwYi85sojDh
	K7SfPvUJ994gk+GEEC3M7UXjJfL4fCIFeh4wigfEbdN1NOlu/1OXiD3xS5Y/SU9p5chPYnETG+O
	va4+MXKp5z0/SEKPkM1KoxfnVmC0IYEaLB5YI3fsFCZVIdTpv+Ygmv6F5hThamEJ89+swPT664K
	5Hsd25B3PfQW6SgV80k91mfe0xKpEPFL7yHjzHwVDREViNlLgijnvPGOtB9Rn86yd3QBHkNfbqA
	M4JiESRdNrH8KQsUKGD8mE3SWV3FCX4XS3JuRN0lc/2n9I9+SNQgFj/V32xieVHhQvZmh8KlF5k
	L2wStltQ9e6qOgUM5TGjan5TseNLPFecNywjVXbJfWwGBs4qfUF+klWMikZdlNfYYe0x7ZyT6k6
	K6ObkCua2xt12TbcSSZVb8tJxgLmjONY2/sti86DQjuGEfKLbTVVZa1YVDxTFp6JC06NJVGpkYT
	xNNoUp+qhkl
X-Received: by 2002:a05:600c:3b15:b0:48a:66a8:9981 with SMTP id 5b1f17b1804b1-48a84463a85mr97396615e9.27.1777625920374;
        Fri, 01 May 2026 01:58:40 -0700 (PDT)
Received: from ?IPv6:2001:818:ea56:d000:56e0:ceba:7da4:6673? ([2001:818:ea56:d000:56e0:ceba:7da4:6673])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8feec2b6sm8727675e9.25.2026.05.01.01.58.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 01:58:40 -0700 (PDT)
Message-ID: <155f9e3da5924a170c28a53fb6ceb5ebc0e539d4.camel@gmail.com>
Subject: Re: [PATCH v2] iio: buffer: hw-consumer: fix use-after-free in
 error path
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Felix Gu <ustc.gu@gmail.com>, Jonathan Cameron <jic23@kernel.org>, David
 Lechner <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?=
 <nuno.sa@analog.com>, Andy Shevchenko	 <andy@kernel.org>, Lars-Peter
 Clausen <lars@metafoo.de>, Arnaud Pouliquen	 <arnaud.pouliquen@st.com>,
 Mark Brown <broonie@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, sashiko
	 <sashiko-bot@kernel.org>
Date: Fri, 01 May 2026 09:59:39 +0100
In-Reply-To: <20260430-iio-buf-v2-1-84c2231dea5e@gmail.com>
References: <20260430-iio-buf-v2-1-84c2231dea5e@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-04-30 at 21:29 +0800, Felix Gu wrote:
> In the err_put_buffers cleanup path of iio_hw_consumer_alloc(), the code
> was using list_for_each_entry() to iterate through buffers while calling
> iio_buffer_put() which can free the current buffer if refcount drops to 0=
.
> The list_for_each_entry() loop macro then evaluates buf->head.next to
> continue iteration, accessing the freed buffer.
>=20
> Fix this by using list_for_each_entry_safe().
>=20
> Fixes: 48b66f8f936f ("iio: Add hardware consumer buffer support")
> Reported-by: sashiko <sashiko-bot@kernel.org>
> Closes:
> https://sashiko.dev/#/patchset/20260427-iio_buf-v1-1-2bbdac844647%40gmail=
.com
> Signed-off-by: Felix Gu <ustc.gu@gmail.com>
> ---
> Changes in v2:
> - Fix Andy's comment.
> - Add Reported-by tag.
> - Link to v1:
> https://lore.kernel.org/r/20260428-iio-buf-v1-1-dcc63ff7b800@gmail.com
> ---

LGTM

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> =C2=A0drivers/iio/buffer/industrialio-hw-consumer.c | 4 ++--
> =C2=A01 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/iio/buffer/industrialio-hw-consumer.c
> b/drivers/iio/buffer/industrialio-hw-consumer.c
> index 24d7df603760..700528c9a0a4 100644
> --- a/drivers/iio/buffer/industrialio-hw-consumer.c
> +++ b/drivers/iio/buffer/industrialio-hw-consumer.c
> @@ -85,7 +85,7 @@ static struct hw_consumer_buffer *iio_hw_consumer_get_b=
uffer(
> =C2=A0 */
> =C2=A0struct iio_hw_consumer *iio_hw_consumer_alloc(struct device *dev)
> =C2=A0{
> -	struct hw_consumer_buffer *buf;
> +	struct hw_consumer_buffer *buf, *tmp;
> =C2=A0	struct iio_hw_consumer *hwc;
> =C2=A0	struct iio_channel *chan;
> =C2=A0	int ret;
> @@ -116,7 +116,7 @@ struct iio_hw_consumer *iio_hw_consumer_alloc(struct =
device
> *dev)
> =C2=A0	return hwc;
> =C2=A0
> =C2=A0err_put_buffers:
> -	list_for_each_entry(buf, &hwc->buffers, head)
> +	list_for_each_entry_safe(buf, tmp, &hwc->buffers, head)
> =C2=A0		iio_buffer_put(&buf->buffer);
> =C2=A0	iio_channel_release_all(hwc->channels);
> =C2=A0err_free_hwc:
>=20
> ---
> base-commit: 7080e32d3f09d8688c4a87d81bdcc71f7f606b16
> change-id: 20260428-iio-buf-4c8559020a54
>=20
> Best regards,
