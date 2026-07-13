Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD063E7BB6
	for <linux-iio@vger.kernel.org>; Mon, 13 Jul 2026 10:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783940043; cv=pass; b=WiiHjMNnIx7wEu9sY7DBNlgALRtktQaGjulYG6C8gZxoFGoF7Ie3s8gi/TbbGXhriZs2DO8s2EVGKi5i96W+IGFbatv9z9nKWaOI2I/HT08suAmkaxZAcx89zX/fIzdCzgylV0YNNtR14w9t30DwKCYhxjrGHwFH5SRZr030YNA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783940043; c=relaxed/simple;
	bh=MPpL8aJbh6rGft7gt536Q0irErU9Ud0HQNDuTuQ0krY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h7eClaMVwV1v7szF9/qFXaO3dX20+Wf7PvmQwBqkiMQZ6ixQVCdk4CtJxN1RsQqRZDVFGbecSjrW6I1yzsiwkQ5NMjow1Zhu87w7aN9XWw1WDhNqHyunxBOSkZXLs2cmvs3yY3ZPpLmNHLdfNq5n97sEHd9p5wgtdPJGQ9PcHCI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P/KgXebs; arc=pass smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P/KgXebs"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-84864086bfeso2962722b3a.1
        for <linux-iio@vger.kernel.org>; Mon, 13 Jul 2026 03:54:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783940041; cv=none;
        d=google.com; s=arc-20260327;
        b=aozH7t065U6BGJJxG5FxtbZWMy5ZzLOaPHBTb2ijw71+56bwTP3TlnyLf5+l/gS9CG
         n0/osji5pWxK329/LTiSJaO34RmapiWxkv0vFJXYbuz/e1W0LMSHUClacaNOTiekMVC3
         DYLfbV9WiI5xuyb3Gje96Fh5n1FdH72V5TmsXueqCTk7kxfEYdYtorDdTJKNG95VXCGt
         JEsCceNuAIl0l0el9SpZ/kFhIMyGSq4dZ76EGkO+bCUnYiqAHpxjccHCQ4+HS9i70jVr
         j3k9coRyYHJF6rgn37YzK2rsjRd1pxK1iIL7pIhTp/7eAZ8Foozu9IXJSfvJnuc0dkX4
         dEng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=wLoRAsmgBc3HjY+oKSwmfO1A8rQKD/ew09Cgkua8Ydk=;
        fh=U3ZoEjBSKVJ0B2RH26w6jQJLliIpJTGtWEbSKJg4Zvs=;
        b=PSMg4+JE6z8bhibOLtjFXx9rHgxu4Y3itspfxTILj87pOXBRgbrODC7pXHZMpa/yRp
         Jp0wjfVI1tkxvrKwG/RAUom0ek4CKAL7dUET/Ze4lWK5bHkScn/Vqt8NSgn9Wb76wR75
         Pks4wdt8zzvZL5Ecg5KfM48o8tV1aNknEuB8BegjYIqqxyW88SmDr7IUQm0y6NfDncqd
         R2ToqtnbUuc4hIRV1naqdd8hnU9S4rPrylQotWuxVY81WH4zti+Usn6i6OphdGTVNMCZ
         J6iJjgPfkskR3fqWcnp4u7npt7sF0milFq+KrIkplxUtxSQQ7uirnZqQ7JijeQVcKxcq
         tLyw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783940041; x=1784544841; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wLoRAsmgBc3HjY+oKSwmfO1A8rQKD/ew09Cgkua8Ydk=;
        b=P/KgXebsjKlChYmtDTWFLpQZuRQ9BlHDCSQjyq2SoFVZlcCTY/SLIEtLZWMSSRRBpn
         9T6pG/VUlQuXRBbGlJX2uVsVi3nHUJ2jpivYvE+BpxJBkS8UpGWE0KfpMvFUv0bguOJU
         bhNXALb2oYfRJE8KdMGDS9dU5BjBPJylUH6vAGMOfvsr/NVUSdy0YJAblUj+OpQw/lMC
         7Zr61/ohbbitOD7URGbfclj7i9gjdGaCKPo+aTd7rvZmijB91X4jrx4F78nzkL6kMos/
         JALv22Vsli3KFt/4poayb1McCpdebssE2innWf5YowxRiV5O4xgbeqFBrAO92h5EPrc4
         vJZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783940041; x=1784544841;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=wLoRAsmgBc3HjY+oKSwmfO1A8rQKD/ew09Cgkua8Ydk=;
        b=VA15viHOJj3tGJbQVAz9GIyF+kDue67kneSIyFLp1NlP+KMIeu/fvaWal2Iju/NDjx
         DQBF4z1s6vwJLDhWeksfP5TKdZBJ5ltXR4bgz9HOwiki0kqY5zopAnthFVKZ6lMicYM3
         OqEBK1foc06V4bv9Ug6cy7OS3HwzaBRqsApsJXsANKRQY8wMNb0njGSJ2QlxH9vjaYJW
         AIJarfvhx2GIHBDULKBWEFX2GLVfP8FAdXMS95u6dwkXZUCPe+goGrWwZ4Ukju8seD9q
         16r/V+hiAxeC7S2W+swZsAqoTHXyOsvWpW/NmtKJgCgvT4jf8QHZrwQREcKKPlHzZDjR
         F9yA==
X-Gm-Message-State: AOJu0YxvfGuAnZJIeSbmeWZa0xt9BBKYAPEYH2IosBYdZ+eQLJCqDpil
	AcqemiEGuty6Dt5OyNP2OjILY7dizS8Zzcq13HdlzjZo1VhV8Lt0srs7If/wvvlNB2sFRvnq4SQ
	j14nhEcfTlw8m7gKrFN8IQkshft9K/s4=
X-Gm-Gg: AfdE7cmuEMdNjJv8WAwTiTeD9lomoA38zfW669upZFospGF131uQcglmqe4j4hgULNh
	2VaZgh861szaHV+S7sltv0eoeebgZEBi9Cx8ccFKphpB75Gezykk3FQgJWAY2E0h9kE/j+KLwH6
	ax6cIojNjUOnFfQlrnFufjczMXONL0U2e97V0NUmgSD2N/p2BpZ91uUI5O8vDp/9hAuGembl3Ry
	O6Bs8KMAZr/Ap1KukYg8oOIU07CNQdXQdkhK71V9mko7Y92F5aMqpAFq1j3ZHxo3FVwG7JmjM/Q
	V10yfJwbVzymraGEjtptc7bzF0TkNA==
X-Received: by 2002:a05:6a00:9289:b0:848:4f04:87ed with SMTP id
 d2e1a72fcca58-848897ecbcdmr7873269b3a.34.1783940041523; Mon, 13 Jul 2026
 03:54:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260711184414.1013686-1-jakubszczudlo40@gmail.com>
 <20260711184414.1013686-2-jakubszczudlo40@gmail.com> <20260713022040.146555b6@jic23-huawei>
In-Reply-To: <20260713022040.146555b6@jic23-huawei>
From: =?UTF-8?Q?Jakub_Szczud=C5=82o?= <jakubszczudlo40@gmail.com>
Date: Mon, 13 Jul 2026 12:53:49 +0200
X-Gm-Features: AVVi8CdwuJDAG48hIUCurbuFyZaaszwmaBxv3-w_PLpCvhWZpNwFgYRLvD7ocjE
Message-ID: <CA+gq5JjOV2J87Ycm6bjpa1o=+eKELt6FZBk_KSdEt1zLiQs4MQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/3] iio: adc: Fix incorrect reading when datarate
 changed in single mode
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, andy@kernel.org, antoniu.miclaus@analog.com, 
	conor+dt@kernel.org, devicetree@vger.kernel.org, dlechner@baylibre.com, 
	duje@dujemihanovic.xyz, jishnu.prakash@oss.qualcomm.com, 
	jorge.marques@analog.com, joshua.crofts1@gmail.com, krzk+dt@kernel.org, 
	linusw@kernel.org, marcelo.schmitt@analog.com, mazziesaccount@gmail.com, 
	mike.looijmans@topic.nl, nuno.sa@analog.com, robh@kernel.org, 
	sakari.ailus@linux.intel.com, wens@kernel.org
Content-Type: text/plain; charset="UTF-8"

> > +     ret = i2c_master_recv(data->client, (char *)&buffer, sizeof(buffer));
>
> In theory this can return short (generally reflects a misbehaving device).
>
> > +     if (ret < 0) {
> > +             dev_err(&data->client->dev, "I2C read fail: %d\n", ret);
> > +             return true;
> > +     }
>
>         if (ret < sizeof(buffer))
>                 return -EIO;
>
I have checked the source code for i2c_master_recv and it should
return sizeof(buffer)
or errno code. Also David and Andy in v4 told me to delete such check.
> > +
> > +     return FIELD_GET(ADS1100_CFG_ST_BSY, buffer[2]);
> > +}
> > +
> > +static int ads1100_poll_data_ready(struct ads1100_data *data)
> > +{
> > +     int data_rate_Hz = ads1100_data_rate[FIELD_GET(ADS1100_DR_MASK, data->config)];
> > +     /* To be sure we wait 5 times more than data rate */
> > +     unsigned long wait_time_us = DIV_ROUND_CLOSEST(USEC_PER_SEC, 5 * data_rate_Hz);
> > +     bool data_ready;
> > +     u8 buffer[3];
> > +     int ret;
> > +
> > +     /* To be sure that polled value will have value after config change */
> > +     ret = i2c_master_recv(data->client, (char *)&buffer, sizeof(buffer));
> > +     if (ret < 0) {
> > +             dev_err(&data->client->dev, "I2C read fail: %d\n", ret);
> > +             return ret;
> > +     }
>         if (ret < sizeof(buffer))
>                 reutrn -EIO;
> > +
> > +     return readx_poll_timeout(ads1100_new_data_not_ready, data,
> > +                              data_ready, data_ready != 0,
>
> Kind of related to David's question: sashiko doesn't like this.
> https://sashiko.dev/#/patchset/20260711184414.1013686-1-jakubszczudlo40%40gmail.com
> I think I agree with it.  Generally need to check for errors in the polling
> routing as well and return those if seen (in data_ready I think at the end?)
>
> > +                              wait_time_us, ADS1100_MAX_DRDY_TIMEOUT_US);
> > +}
>
sure I will update the function to return int instead of bool and
check for errors


-- 
Best regards,
Jakub Szczudlo
