Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795669181;
	b=cDJ8c6zQjPP4Z3ivzds9G+rE21JGNbzq6DvQ/k/X1xLYPPOYm8hQfEDWoyemSdxGg/fe
	 kxnUES1DOPmbxvBVmT7XGwFWm+mrVjktqT1lE4Fn1aQsltanQr0oLKi4lYzdXiBFqYRgL
	 j5htJC/9Q+C9q0iUqOuUUM0yqwGL6m6DO9vm7liJaZ7lK2e5muM5GSBldQq2xbFqwc4c3
	 5C6YbwpQX8LYIBuUnUq9iR6F+Q+Vxav2Qr5o5hoI1l3to2ntFBhPzNy6oeUDS6oczyjp1
	 NATVePU8bOR3BOEoL1UNjIoFPATC3mzFA/Uk20Xp6i8adm0sBt0cRvpX7aBrlXNFtHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795669181;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=X+nJHVRosiUPbQF5ndFjmNHYck9oE5omsocbkDSOO/o=;
	b=VyuTnjizEdfL49oE5Z3xIcwbSmx295STja/+bS+EyRkCJkZkpWWI2xlBId6tgAqT77dw
	 4H0XZm5D6IEAVQRN/lTVBaG6e9R/UpGTjDK+/fx7vj4P92LgN+YeK46atRNoHg3NLYklA
	 jbule88p4yo5Kf4Xf34I0HyPi9YFSoaTgyrD/B38x40Rf7anqJfGAb5G/Jy4wYoKO2/ed
	 A+clGgZ+hVvnYxOVQcqMFu9AiaTOo+oGw4UGWHKj7k6h96fWJ+HeQkonQhTL7mv7t9oo4
	 L91rLCVwewakYvuUKg8DBs3JQJIXf3HjlDfDddaK9LOUaaNKWFLfz3sq6dW35T02BkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=L1z09xs+;
	arc=none smtp.remote-ip=209.85.216.42
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C160606A321
	for <linux-iio@vger.kernel.org>; Thu, 26 Nov 2026 04:59:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C160606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=L1z09xs+
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3ae6b4c669fso6108867a91.0
        for <linux-iio@vger.kernel.org>; Wed, 25 Nov 2026 20:59:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795669181; x=1796273981; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=X+nJHVRosiUPbQF5ndFjmNHYck9oE5omsocbkDSOO/o=;
        b=L1z09xs+l6yotNjMoqY+4OnbwTKue1rlBTJL74KHEvHu5gxCUa6rWoKN0TBHkzjItk
         pkdeWwdmpchcAbPf2UTu/oC/H+4uEyRl4HFmiTJ+U43xXkPQxAeP0gWkps9bBK6s3E7U
         GIw0jMeC74HEoJp2d4QjVj/caCEtIoOecjfJZEVtslVz+p/HXKQSgCFIAZ4blsUluy6R
         kIRZHUuUWVXJg01pCxzpMWgcAokcsroMjmSrpGTiyKjwxPOOufwNDCRJxe1Rx6YZ5tPt
         ZYTEX1wWvsR6/ossvz8czGlw/I4VRCtGc/p/BoviCxTDB/hzdy6J8b3XtS2pPza9I6za
         XG4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795669181; x=1796273981;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X+nJHVRosiUPbQF5ndFjmNHYck9oE5omsocbkDSOO/o=;
        b=0ZR0cyOhNL9gI6G3las68MuSLTqPjJUe4l35VopP/YrgrO7qCXPhT/Amp0ulmK7xk+
         mmIuusT+L+pRm58tB0BMeTCx8GbvI2tkoaUJfGcF5ceuwP0kv8h63nW/xGnIVEhPO5Ks
         34waU3fAVDlF54OyQ9kfRbGNUmTRrBqVcrSg/B4fA+hjfwME2PSFQJ/jcm9a3o8YzkCB
         mHCeEEVioe+753HcU9DYnZ8F0mSMqrWEbNvw+19e2ZsAiUHEBDXhQxlxC6b86KHBHhmQ
         uKrj8S3MpZe8Cd0lKdChehcY87hqUcjBjsRv0bCqM7LgVwcF9dsxabttJk2CNWH8WIz3
         DDQg==
X-Forwarded-Encrypted: i=1; AL+hErHIB7ZTuW0Gax/pfFRS0i2BqyiYVVb7dCPM2gIu5rSUtwC4j9uBeqpdCRblFH0ADoshB3vKQoiY0GI=@vger.kernel.org
X-Gm-Message-State: APuU4Z+H6CBtjz8LO+nL577lJC0Fda4jrPEduOH9dhwR9NQujBc33Qe6
	LMU85+p4yTTgSU/bsMWXUzD4nXOvlzXgmEaVeVqMM4QV1M8v+HO5E0Jj
X-Gm-Gg: AZFdTZfde2dszaRjTgsEe/R8wYvIoIWbkK0IOLu96oupwRuUSLRXF4CiJGqzItRbjfa
	zMeiuRlM/RMHcxTUhJgdaHXmjG/TpEk6DWhs/9KGOb0A4+E+gE2Xy2Qkz8KA6lELiJSR7Ny2xnR
	aA6clQnLvim1CCVe5bS85kSwHU0wE6l7yqfU6hqYlwpIKMzwLlhBnveAYoyasfn8i9ZQJWfuUuO
	NvMFQXRj5L8xXb+0vCLubeq7JVQVJFe62139P03r7AHdSUkTc5bl2T4VhOlhEsGiS5R6w3ODNEI
	dPB5nWBTEZl0etE5Fvzr0f3KjgZf9kdtA+sn3jfIsDD4WBqSQwIEL+2uhxfLh2HYjG4E2S0VUpk
	0/yttMF09HPQiYvNAOIVv4D7iz1NrqmwvtdWdOzTe783sKP6ZET8HwqQwf/wCobm/vL7G/q9aM3
	T/xAUEypHYq+2JlOZThsF1pvgOZcfuk8n16i3T6AR2OO7L9v/4ovxglu3kxw2G6zcPcSDAFIXM7
	t5CvQsOekiZFSl9QraM+0eelmsdVa425+9MLclDK7f1XrhxL/hQ19J5Ierg1Lv/2XZDj/bbSIaM
	eJJtOaea2awG7ZRXjd3dWpdsyKzcVHSJo6kami5kmM1rBNNB/JS+7vIT5ZwoYyocLwr3m7Wi+TK
	cD29EYuu+kNO3XJYZs/yuuSaleD65gdyL+Pe1w7gcVWVS//lhQEsHu7S/O9wP5guKStfaxHUjS+
	F3cJI3Xwdp1NJKnGd5vYYgMNg=
X-Received: by 2002:a17:90a:e710:b0:39e:6c68:fd91 with SMTP id 98e67ed59e1d1-3b41c96151cmr12803039a91.38.1795669180620;
        Wed, 25 Nov 2026 20:59:40 -0800 (PST)
Received: from kapoor ([149.40.62.17])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41ad46ef5sm30661677a91.8.2026.11.25.20.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 20:59:40 -0800 (PST)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: Zhiqi Zhang <zhiqizhangg@gmail.com>
Cc: Tomasz Duszynski <tduszyns@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] iio: chemical: pms7003: Reject frames with invalid length
Date: Thu, 26 Nov 2026 10:29:28 +0530
Message-ID: <20261126045928.518052-1-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261126041911.55827-1-zhiqizhangg@gmail.com>
References: <20261126041911.55827-1-zhiqizhangg@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, Nov 26, 2026 at 12:19:11PM +0800, Zhiqi Zhang wrote:
> Accept only the fixed 28-byte PMS7003 data payload and make the checksum
> helper reject any other length before deriving the checksum offset.

The out-of-bounds read for lengths below PMS7003_CHECKSUM_LENGTH is
real, but 28 is not the only valid length here.

pms7003_do_cmd() waits on frame_ready after every command, not only
CMD_READ_PASSIVE. The replies to CMD_WAKEUP, CMD_ENTER_PASSIVE_MODE and
CMD_SLEEP are short frames with a data length of 4, so with this patch
they are dropped and probe waits the full PMS7003_TIMEOUT and fails
with -ETIMEDOUT. The driver also binds to "plantower,pms3003", whose
measurement frames have a data length of 20, so reads on that part
would never complete either.

>  		num = get_unaligned_be16(buf + 2);
> -		if (num <= PMS7003_MAX_DATA_LENGTH) {
> +		if (num == PMS7003_MAX_DATA_LENGTH) {

Keeping the upper bound and adding a lower one should be enough to
close the bug without dropping valid frames:

		if (num >= PMS7003_CHECKSUM_LENGTH &&
		    num <= PMS7003_MAX_DATA_LENGTH) {

With that, the extra check in pms7003_frame_is_okay() is no longer
needed, since a completed frame can't be shorter than the checksum.

The commit message point about shorter frames passing the checksum and
leaving stale PM values would then need a different fix, e.g. checking
the length in pms7003_read_raw() / the trigger handler where the PM
fields are read, so it is probably better as a separate patch.

Thanks,
Arnav
