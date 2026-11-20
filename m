Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795208621;
	b=k0zAvGmdEPlFh3Lz2wl2NfAAxqZ9d99gdxWMzcArHqzTQ6nrr2Ym767YOBjIouXGUmoe
	 wAmXm/XB72dAff+WN0TkBFAyWL8Thbgy1dqkmDAh1LICCD3/i6CZYLkyr54971iHGKpNJ
	 qIL5RXc4tmlyorrY3sZqzasWOIXXNL2P6i4haD/hNJCFQYoG6jT2W9Q+xepLRO7DAJIeb
	 V8QN/uEnXW56xptzygn4JeB7KbZ8s6y2QvZwW8U4MGu9IrGMG6G66h9+NoSuf+aFK4CbQ
	 jz0DYl0ldA2F5Q4H7BvUTGo/rD4x25WnhLhCzD4EnQy0IMBFdk8j0zDwpHkzPPEddnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795208621;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=4hK94eNEEKjazlQ0HP7i05TipBfA/Zk6tSc1DEj8pPw=;
	b=UEoVZwHn0p+akyeZNP6o6mOtQz1PV4OLsk8dAc0SeQl2CrE395dBGPe/oRB4IbLC0T4H
	 bPCwO9e3waNHybu48R+gVsJCTLxWPAl3yNQ/Fs3SLHttOCYje0f13L8bFrAa03xBjdR0M
	 TYIMo5PnLH+5dPdd+z9zFM7VTneJEARY3VIUTMEaejqU9HQiFnhcOUx94u+pMqCtRVFzv
	 uwma5LzvBo1n7lCtTbFdRrKFn6rEXOtdYBUCEIBy7cOjdBS0ylOCHdJFdFIpBGjJG3LfZ
	 Fd5g9MmcnjntY0w6dqeWjFELw87R6bl60zq4vCHgxD5y/a4+Xp3vNTFaN9FqItkcfWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zyVDb0g9;
	arc=none smtp.remote-ip=74.125.82.48
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16A5606A699
	for <linux-iio@vger.kernel.org>; Fri, 20 Nov 2026 21:03:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C16A5606A699
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zyVDb0g9
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1a3c08d6928so1828443c88.0
        for <linux-iio@vger.kernel.org>; Fri, 20 Nov 2026 13:03:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795208620; x=1795813420; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4hK94eNEEKjazlQ0HP7i05TipBfA/Zk6tSc1DEj8pPw=;
        b=zyVDb0g9yNO4Zk/jlweqhoNreS+trSst0WrNaXSK85spzN1Hm+va9kymYhXTiIkrOZ
         6FHA39FcBFpPKPtAwfQCnLic+8e7hytQSDcPHi+lURZxiDryHmnzvcIC8uiehjjTwh1b
         4k41EJ9+7wMzHK649P3GmSd0sC0a7G1v8z9NJmor1m4v7XqLftIf9qCEtLw7TmwhjSNu
         R8dfbLW8taucG3PW4x11LMxJU6690Q15qL8BvYjU/gbv4xl2SGmrnIu0ulk4la6tn5DA
         UnjyfDoova+wX1aiSzQxv26uOcfDyqDe8ml6hru5SWzrrSPw/CmeJQjN2tyvwC8fupJI
         VOng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795208620; x=1795813420;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4hK94eNEEKjazlQ0HP7i05TipBfA/Zk6tSc1DEj8pPw=;
        b=lHgrEX0nGHtUSmNSjr02qt4kbWaZVvW1TeC5G9B8OKj/ZrWIYTNGhFCxaBDZz5/Bja
         guQ2Uv38LkTzwfT5j1kmLDfsy1ml2ZU71Tm/JGVoQFfdBzUks/hKby/y3wZ/Qj+QFdhA
         Ax+D1fglnEGbB5vmHRwXrLox3TftKjxN40cJm0CtmvjqhFlD2MeZu2XtXXP4hGcR/FdY
         9bS+qI/2b4gykesDOyPT/h7LIvOeC26mASgQ2wLGj87lZ7HbzJtwvTbPENnY7uz9fUze
         D+8d+abi2JHoef1SpqZeClaSoQCwGNNq6n0NLgyIydFpw48PcYaqMUROnxioo64FDv3M
         hCkQ==
X-Forwarded-Encrypted: i=1; AL+hErEFwpRCkUYFFZstkAqI2wv5VLcwyZhYpvqjb4/Zg5W0zCWDOGhbCFuSyQjtch3B+oQ1uTj0jrsDEr0=@vger.kernel.org
X-Gm-Message-State: APuU4Z/NarqA07jUNBzMTO2tSMtS3xD+HE+93POfrnBT0MXEeXgxMMke
	679z0WfXa+Agq3R6P9rPTgCZKgh5IJr8LOtbztf/Axo6Mj3nXZl0qQ/X
X-Gm-Gg: AYBFou1XsyO15zyBEKFldAoTwVXlZKXDwcJIETO04N4NTKnWomPKtsf4IhCnsBQMd6M
	Y3VrHIZPymzq2hsTOLc1KfXhu6hKrPURNaU7R26TFpeXFAy0MTB3Ve0Uksu3eO6DUbYEKH5Whj2
	gY4GlMCOO05bTGhGZpiLiWY7veuMjJQxvad6L8KFrisBxCr26N5wDVkfSEVEG+0fXnXt9C6No5N
	hnRZvCw0sOsLsgbrS5PmSmgy+u+qLgex2lrzOZSJApThX3s2po0N4DD17oWN9GPZgcK34nuvOMR
	EF0JcbFOVLyUynqyIuxzZ7v5ffESFRhpC4EjqlIjpOihj/oAoz/amOP3dzxMhRV+x64UsQlPoiW
	69RyaysyZdaLsX6xYWlk2YWX7TEGaD92TwCfZiJbVeG4CcJ89XCW+TuYiddTamgdv6OHp01Ct2a
	y+hNkZzsL/aKIHAq0O2Cu9IQNlMINqqF4W+NvVx0geWZQVUdiK7cfdQk+t5EpnMHxbkd6J6/xo+
	OoPMD7GLhSaG0QW/qLw3RTGrKEC8ECm9P3WvkgGf0A+gtegWndB6NLuNb5qbClvtMzwxOP+3HN7
	d2HuU+B+xBelVa69r+MAAXrFpkdMIzeZXsnOm0nrT17anMQ/+8j1KV+7Zr0wDw4lsUm7WzOx8zq
	6AuNLRxhiVmzshA7LCSvVYwR+TqOKKsDr7PZ2Kmb9qLP1Iq0i+H3URZXwLdKGdOPpgCkqTIDVyF
	4su9YYiquxD7h3VGBwrHbLtL+60Hn/SazZz6umtFcHwg==
X-Received: by 2002:a05:7022:3c0c:b0:149:1b5b:1f25 with SMTP id a92af1059eb24-1b55688bbeemr3318551c88.15.1795208609113;
        Fri, 20 Nov 2026 13:03:29 -0800 (PST)
Received: from kapoor.iiserb.ac.in ([203.18.51.239])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5566c1142sm8865172c88.2.2026.11.20.13.03.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 13:03:28 -0800 (PST)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: Zhu Jun <zhujun2@cmss.chinamobile.com>
Cc: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools: iio: Keep the buffer index separate from the acquired fd
Date: Sat, 21 Nov 2026 02:33:17 +0530
Message-ID: <20261120210317.184756-2-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261120061903.98141-1-zhujun2@cmss.chinamobile.com>
References: <20261120061903.98141-1-zhujun2@cmss.chinamobile.com>
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

On Fri, Nov 20, 2026 at 02:19:03PM +0800, Zhu Jun wrote:
> IIO_BUFFER_GET_FD_IOCTL takes the buffer index as input and replaces
> it with a file descriptor on success. On failure, cleanup can mistake
> the unchanged index for an open fd and close a different file. Only
> assign the returned descriptor to buf_fd after successful acquisition.

Checked against iio_device_buffer_getfd(): on every error path it
returns before copy_to_user(), so the argument keeps the index, and the
error: label then closes it because buf_fd >= 0. With the default
buffer index 0 that closes stdin, with -b 1 stdout. The patch fixes
that, buffer_idx is already rejected when negative, and it applies to
iio testing, builds without warnings and is checkpatch --strict clean.

Reviewed-by: Arnav Kapoor <kapoorarnav43@gmail.com>
