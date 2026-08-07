Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956D53D8103
	for <linux-iio@vger.kernel.org>; Fri,  7 Aug 2026 08:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786092900; cv=none; b=tYZv/e34OCp3NRGG60t9/ukoKtHGHvTSK5f/4Hi4BMjIaNYkeEYUHNmK0yN+NhqmH+WMyWT9vqT5Qlu+LRNcI1+4Yp7DCdcxzCQArM9c/AT9WIcVrzoK5ljlBNiEMnftGwCiOxfQ74yZdi5Vy2AiLLfef1OgmCq4gf5aiAdf6CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786092900; c=relaxed/simple;
	bh=W7DRp7+AjN5nzlthpslQyqsiov8QvA05Vp0mVKrQGko=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XLgYOLVHRZ4IwQxu1svHqsjW14IZBqh5gcZDHt6c6H3zj2eUHIfTOy9TNMixHoxBmh666qI8qVVHpixI/sY01OSdzbOERT+31ku3ttD/f3DHdfwSJ/5/wnEtHNr4zbjjDipAp5Zo/MIr92yDAYT3fR/jEf70cg9bJdfBe7hI/LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=henneberg-systemdesign.com; spf=pass smtp.mailfrom=henneberg-systemdesign.com; dkim=pass (2048-bit key) header.d=henneberg-systemdesign.com header.i=jh@henneberg-systemdesign.com header.b=QQVVrahV; arc=none smtp.client-ip=212.227.126.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=henneberg-systemdesign.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=henneberg-systemdesign.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=henneberg-systemdesign.com header.i=jh@henneberg-systemdesign.com header.b="QQVVrahV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=henneberg-systemdesign.com; s=s1-ionos; t=1786092894;
	x=1786697694; i=jh@henneberg-systemdesign.com;
	bh=3hGDYIpT6fBUcK8fWLnSyRK1830StjG7rWOx3R0rQcg=;
	h=X-UI-Sender-Class:From:To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:cc:content-transfer-encoding:content-type:date:from:
	 message-id:mime-version:reply-to:subject:to;
	b=QQVVrahVtQjlYQ4iXXPwP4ReVZeVXlXYlyk4Yv2uuKXM1C5mALjmK3GjHabjKYeO
	 LsW0g1BOh6vj+eeXY9BE2dGwc2bSy0/s88vOquwr57u0qrZhBURcQYPirshBTN0UJ
	 w3JRiA4UENz8PTtR8jAeB/MUJ7usrhOAwRRKfdKyrdYY+TGsv2B8KTF9M6HyWqhq/
	 la4aT9sN8DzFPvB2y+HbTrRju/8Qc075flHuO8dMVLZZSmFaIym3Dfh0NntTfxXRn
	 jRlhf5vIL7DPm56LjRCtpfvs3XQ6nFHmNymviBtKvdyG8QzzdDg7D6uk/lXSZjp3+
	 8Q4mUf4Kx/6FO6gfmA==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue012
 [213.165.67.97]) with ESMTPSA (Nemesis) id 1M7ehh-1wofSk0bhV-00DGxy for
 <linux-iio@vger.kernel.org>; Fri, 07 Aug 2026 10:30:15 +0200
From: Jochen Henneberg <jh@henneberg-systemdesign.com>
To: linux-iio@vger.kernel.org
Subject: Question about bno055 mismatched reset gpio logical/physical state
User-Agent: mu4e 1.14.2; emacs 30.2
Date: Fri, 07 Aug 2026 10:30:14 +0200
Message-ID: <87ecgafi3t.fsf@henneberg-systemdesign.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Provags-ID: V03:K1:XBJ9WCSroXNuWLKo2epNIEhuTOSfELoM44xu9YMZclnIalVHjFn
 oFlAQVne5aOFcuhoE0Sj7Te41MdKRJRGdPfOob/pn6dsBUpWRdnq+juf1r9ZvMXU8sw+oXL
 +Vn4WWY3sWrvQ8pwGvHnbz6iFq/SysFDMAzNAe8nGB8Geuo5WzOHy8YrorJKZOaY01aQTpj
 MSXI9bwR1g8tZCldDQP1g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:3yOcwPfMBFo=;8GWWbcwR1t02G13JsL4HYp03/Va
 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

Hi,

I just stumbled over a mismatch in bno055 where the wrong logical states
for the reset gpio are set and I'm not sure how to deal with it.

Looking at:

static int bno055_system_reset(struct bno055_priv *priv)
{
	int ret;

	if (priv->reset_gpio) {
		gpiod_set_value_cansleep(priv->reset_gpio, 0);
		usleep_range(5000, 10000);
		gpiod_set_value_cansleep(priv->reset_gpio, 1);
	} else if (priv->sw_reset) {
		ret = regmap_write(priv->regmap, BNO055_SYS_TRIGGER_REG,
				   BNO055_SYS_TRIGGER_RST_SYS);
		if (ret)
			return ret;
	} else {
		return 0;
	}

	regcache_drop_region(priv->regmap, 0x0, 0xff);
	usleep_range(650000, 700000);

	return 0;
}

To reset the reset is first turned off and then turned on which makes no
sense unless the gpio is configured active high for an active low
pin. This happens also at another place in the code.

Question is: Does it make sense to provide a patch which will then
potentially break dtsi files of many projects? Or should this better get
a note in the binding documentation?

Regards
-Jochen
