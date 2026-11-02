Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793585564;
	b=AEKrv+PiRiAbRx9tNfTE51y27djkCRmG5TtpxF1gVto/f7OhDE8Zil3n9ElnW1WLLNOm
	 Fc0FejIqc3YksCimBAeG794/Ux9+wRTuRlzaLBNRp5nsKtuU2kJRtdPBCHOojvE8zSKy7
	 wSWiUbFMdGUuQASLLnczc6risfV5tSeKjjwmN2VbhulnQcvEilOqMvlD0NO4eIlhpmH6l
	 IeG4pfXU+OZSjhoWxgaqfyBPkdvfmfudOTnILxS9Hk8U+voMwHrZWDbJvAlnKjxw3jchR
	 LSLG804bh4G15Mtbhj1CrWF/LuhHscBm82zK1LqrTByVaEQnQx6t3qr4QYeiNQEcy4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793585564;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=rnK9hs5gZ9Iaj1SOgn5xe02FN8ZLgt4/R/BT48R7JvA=;
	b=jXXy3Ukk6rk0lQIhsR6XZ7uVB4FczREC3bujSk+ldI5LB5xkLwHbqFgd7LFNoHidWaUH
	 F7liBZZZb3f5PznwvI2+5nzqVl27ckMmfroTluZG2kBqALNNhIEMelGmDT4bCRL96r0sh
	 Wg+XjUpRapbJ7AO52wk76txX5Bd67niSLUwCKJ7zgXUEb8zhAri1QfYqQ/AU8hCFu68TI
	 DbA6GY0Siy6CYhipUrGCGSegSbrXdJTLA+5TEIfK2gh2ZNrrYr8PS13tqoL3AOhOkF24L
	 5wt55nRCC22stJKLP+UDvGW/be/jdJCbEUPQNQFNKngzm+EtbsWhTr/XylBdUwllcOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=pwZvA8gg;
	arc=none smtp.remote-ip=111.22.67.139
Received: from cmccmta6.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 044EA606A324;
	Mon,  2 Nov 2026 02:12:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 044EA606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=pwZvA8gg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=pwZvA8gg3RQsOAVV4E6nHLEZl2EvuTjrYCM2Mq6d4S9HzbAuXGeoYZt7ornr0QJAK4igMRijJsAoc
	 5454x9EF4BIELy/sjh5GMG6Rw7FS3YIW1xfLmxqq1Gr+I8LIUxGS9RTUxNwsTQHEEoPkN4qpdxqwSG
	 1+TyO1E6qSlNaDaQ=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app09-12009 (RichMail) with SMTP id 2ee96ae7f17afcd-88dbe;
	Mon, 02 Nov 2026 10:12:10 +0800 (CST)
X-RM-TRANSID:2ee96ae7f17afcd-88dbe
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from DESKTOP-3K8GUTQ (unknown[223.108.79.98])
	by rmsmtp-syy-appsvr04-12004 (RichMail) with SMTP id 2ee46ae7f17943e-f6006;
	Mon, 02 Nov 2026 10:12:10 +0800 (CST)
X-RM-TRANSID:2ee46ae7f17943e-f6006
From: laixiangwu <laixiangwu@cmss.chinamobile.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	andy@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	laixiangwu <laixiangwu@cmss.chinamobile.com>
Subject: Re: [PATCH v2 0/2] iio: gyro: mpu3050: Fix runtime PM refcount leak in trigger enable path
Date: Mon,  2 Nov 2026 10:12:07 +0800
Message-ID: <20261102021207.382-1-laixiangwu@cmss.chinamobile.com>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20261101172822.6591a452@jic23-hlaptop>
References: <20261101172822.6591a452@jic23-hlaptop>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Jonathan,

Understood, thanks for the heads-up. I will start a new thread for
each version from now on.

Best regards,
laixiangwu


