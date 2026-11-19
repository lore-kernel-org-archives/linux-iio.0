Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795119363;
	b=L++b8ZeSfP3W4E2G2UiLHrK2BRZo6RbfJRgeTrgMxheYl/AFqMfORdpgBG4nQhK072Zr
	 DbuVUFxo6nz+gGrI6QlBuBzsU9Co+d/0S/XHbjIkqlOzSbkIai66sntChkm3j9gGOWybG
	 TWnpq4nlspXCVDrL+4afNDwHrHLhkOkumfoKdzoD+5z9Q6NEn+fJ2bVkCBmfHUWlFOSOM
	 y+javujeeFCGNw/VA2uKcElKWG3dr7WIECDYhCFoooaI8WzsqKQKjqty91BcQ4WTeMkuY
	 qbPI8tq+PQ0mXG7ohQGZArHTIVIeCAgG6hRIF/h0s6RL+Ytx4PLljyfqWhuTHt6JN3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795119363;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=IioXAUgBLX6qGXmIL+lHfh6K/SMkoqjXHsXvXuXc4kw=;
	b=OOM/5e42o4GKC1s3vLQjNZx/UxYEtVWc9q33/aLRF7mr9QmnmAAHSN/yJkANM5XgaxSt
	 fvARPMhTYqj92mk0LcKc6o4rkKGoShUSKIe4QJue4lkUNAeiY3ZxvYYi6EAkaYb1SOndc
	 +foscgYyJZBhu6qUB4ej9+8amrFc2puH+FjAz6fgwudjPxazeJohoNc2scuMHBL85yLZn
	 RthA4NAJpLQFGxxdzBdtPdb1nAHVe9N/sTB4cJyRrF33LvI3dZ9ctNQlhAvYuwd/bSHgF
	 J6QnX23DUjDua4oep3eOnR6OhDi+qJ/iYYp2nAQZvj6YUIh5t2U1k5CbHySEZUc8yeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yinSp1IW;
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E05606A32A
	for <linux-iio@vger.kernel.org>; Thu, 19 Nov 2026 20:16:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 50E05606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yinSp1IW
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-38318d69173so222427eec.0
        for <linux-iio@vger.kernel.org>; Thu, 19 Nov 2026 12:16:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795119362; x=1795724162; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IioXAUgBLX6qGXmIL+lHfh6K/SMkoqjXHsXvXuXc4kw=;
        b=yinSp1IWy19Mc0Uvru8QtwhV79tjjpVKWi1+9FHUQHTEdVmwh7FMqghXtoaFhil3Up
         HuJyR8YsyRLwKs4GnH+Dq5WPejkKt36FY7awxnFTJB0xJB3kuj0hjJ8LjQHaNYiEaKLt
         dcGwROZVLMg4UrfyMlUjcNs59EyPsnwAkV+ttTTNnaZMx0BOOaS3ovLp9O5ZAWLK6AeB
         ZuAEHqj3ZflLDXxARL/LXnCzMb2gmeEJLIcSsZHXdUyfF+n/4zqZvZgZLFG+tmG0sNA2
         GKL5jSf0lxUk7HNvWtwDf2IkOW5uKBbVI/ZS2ENqhhG0wSeCfavwncA1dCEpcxCDleB5
         /rAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795119362; x=1795724162;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IioXAUgBLX6qGXmIL+lHfh6K/SMkoqjXHsXvXuXc4kw=;
        b=TbMz1apH9lWuhEskdGkJN7QnXBDNon1wsp0MKtCgau7YV2R/rPPr1EA2oKhu6Uw+em
         3ikUpd9CWqoyefig4DCyyUY21751FCsO3B9BN07+I9bWUaILYlTmKWoruKGRijz8A1Kp
         37HH7bMgtpsP2euJ42wmV54lTzZcH+o8RfOy9M1hcJRbq8E2i4kzyA97XL6DB2QHW46C
         njrO4ui3i3ty+AK13o/MNFoZv5igLQM5kZ+h6Tmf+TVV8HWW27ipkn++qWO34alIqN0W
         K51wvZ4MIEo8KE2Ih/jJeKE5XarPRHA5nhSoGVEWycnK6e7BIMy5sCatPeNM8SF4Qvby
         /rhw==
X-Forwarded-Encrypted: i=1; AL+hErG9TdoRUDe3tdfizflsK7UsMlXO4eDEA9/BD0N6rLuT9nwuXHsmaARlx+mbDSCQt/Nm4lowRPhyGxA=@vger.kernel.org
X-Gm-Message-State: APuU4Z8E6d19Y2gBPWj41lwXfMepPQ4elKZINIizzOpLX8esqdVtlN+u
	PYBwuKQ5g/Dv1BQRciT/rIuDAog1NvajRrKOcXqZenzfc5YWoo4EGxrm
X-Gm-Gg: AZFdTZcI7eQpA4j7lic7VTYNjPD+od1Kzk2s5ptcwTUgE6PJerxYPLMb1fyGufBT1LW
	AktCVVk0n2YIgodNsl1kGbSYu1eW/EPAmM1YeJBguVInamFTUv2Ip4geYxHUXl5gzADjiPQuoRF
	AuBBlw76K62tVvNOUPrHTwX8jt6m1HpEWQbiKLVabjsgt1Q2dYRgRggr7z/LX+RNncQ/qZfzxPL
	MF6iJTO+Tg3h/YnyfN1G1ao+sAZHeVyMFNahHl3aDVKxR/gpNMAJm+mcdvLDb13OU8dhGSvmMbj
	gl4+7xkyl8qXQyhpGk2ezg04NnCuEawbxTZ5aGqrWvWYE1tbl/u5FPn7e+eqNiexcj67m7Dxq9V
	eVoKPr8znmM1ISxOKQfESEvUbBNnoa6Wc1HfEMenkclfM31gd9kV/fe8NKscRA9/8eLa2WF833L
	HEkq42NxyAtytiX0Z8RjHuHLCt+xvfKwblx9sfOJ8IxpBFbGkEzV4hdH+yGYedrlnD98KpT/PFZ
	u7v6q6exLs+W3zji5kJLXsj8qVtv+h3Up5TMlyWb8OhfqoZMQYiIc73yYaMUp63rL5Ph+mNzwC0
	muLd15LEnfKH8nMvlGjdFVbuts3AcWJJo966+FRGwExnsT7v3s+Swma6rwjR1/iOpEJKw2ieaQ1
	ci39HBLwTUGC/1yJFiWY2eT06WydQuPkRGQ5oz5V2VdiytmJ84cGM58KZz7MloQ3GsrQjYDC8W4
	z+NjiWwz+D8mSB4s5Yl6zL5EaV+IYlAgHra1h3ZxmDPs4=
X-Received: by 2002:a05:693c:87cc:20b0:358:3426:d601 with SMTP id 5a478bee46e88-3856c0d0961mr448850eec.2.1795119362463;
        Thu, 19 Nov 2026 12:16:02 -0800 (PST)
Received: from kapoor.iiserb.ac.in ([203.18.51.239])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38567daaf70sm1097351eec.28.2026.11.19.12.15.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 12:16:01 -0800 (PST)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: Ayaan Mirza Baig <ayaanmirzabaig85@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+fb951970a334aaff00ba@syzkaller.appspotmail.com
Subject: Re: [PATCH] HID: hid-sensor-hub: avoid lock inversion in sensor_hub_remove()
Date: Fri, 20 Nov 2026 01:45:55 +0530
Message-ID: <20261119201555.185270-1-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261119192046.1015750-1-ayaanmirzabaig85@gmail.com>
References: <20261119192046.1015750-1-ayaanmirzabaig85@gmail.com>
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

On Fri, Nov 20, 2026 at 12:50:46AM +0530, Ayaan Mirza Baig wrote:
> Move spin_lock_irqsave()/spin_unlock_irqrestore() into
> sensor_hub_finalize_pending_fn() and pass data through
> device_for_each_child(), so &data->lock is only held while inspecting
> and completing each child's pending state after klist_next() releases
> &k->k_lock.

...

>  static int sensor_hub_finalize_pending_fn(struct device *dev, void *data)
>  {
>  	struct hid_sensor_hub_device *hsdev = dev->platform_data;
> +	struct sensor_hub_data *sd = data;
> +	unsigned long flags;
>  
> +	spin_lock_irqsave(&sd->lock, flags);

...

>  	device_for_each_child(&hdev->dev, NULL,
>  			      sensor_hub_finalize_pending_fn);

The commit message says data is passed through device_for_each_child(),
but the call still passes NULL, so sd is NULL in the callback and
spin_lock_irqsave(&sd->lock, flags) dereferences it. That would oops on
every removal of a hub with child devices, instead of the lockdep
warning. Sashiko flags the same thing.

I think it should be:

	device_for_each_child(&hdev->dev, data,
			      sensor_hub_finalize_pending_fn);

With that, moving the lock into the callback looks right to me: k_lock
is a plain spinlock, so it shouldn't nest inside data->lock, which
sensor_hub_raw_event() takes from interrupt context.

Could you send a v2 with that change, and say whether the syzbot
reproducer runs clean with it?

Thanks,
Arnav
