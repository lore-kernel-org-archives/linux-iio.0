Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795538103;
	b=JimIicMWINtTJG5w5xXcDA6yw0R1EXnhslkr/p/LTWqc3sW6RJzpwCG7nxIzH+klY8He
	 FWELRWq3VnkbYf/wRmP6gxaJ/1HjCvfUCLETmca3gUX+j7WxAWR/30dyoprNp9hu3QjfM
	 saQS8GiYldhBOSWCOKY+QVdfKxj22A97XhsT3ndVd8m0PShd3Dvuwp8o1PBC6+2HCVgFU
	 WUPcohJ1yEtsze9b93EdNusWW5S16f1LaLqHVYSJeQRw28I/+cJzUbEJjL68RDNU32ScL
	 JsVGFRq/xyET3SxWjysprZ+9VXAM9I3nUONQaUa6AtwyLdJHSFrIOJt2Q4ZzHAfGOKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795538103;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=XOpeZy8A3uwCctdHiax2vOOQfiE+uheW2bk2Hl1THXs=;
	b=RPqim4rC0kFGS/JBtvh7zdgTrL7RR5IRvUGJ/hLz6Gqg2Ubogq90/BatWyQtAE8j9GZa
	 glYbMmFOmpOOKQyAjqK/nlYfCQ0vNKHgzatftQTmG9MODbGM3aha215YZHXvWPQNhT8vQ
	 xsVT1EjVd/xar5QXE+Ewhzthdzqx84TfMGKK52IbIstET9rqHBgzyoQYpBDIYWZC8kKOb
	 Ey3iiZpQ49hayo0yY6Z/kdNEQxzQm297sW4/aAkVH+EChQch/y8YkzoEGVSm1qpsFp4td
	 14fMUtgt+m1E5l/2sc0RkwaiS/yct0Pda21lVvuAKzP6Nvf6+zt5OVUG2S0an6vWw6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HeExqdVO;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C4A606A31E
	for <linux-iio@vger.kernel.org>; Tue, 24 Nov 2026 16:35:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F3C4A606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HeExqdVO
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-38190551625so9561291eec.1
        for <linux-iio@vger.kernel.org>; Tue, 24 Nov 2026 08:35:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795538102; x=1796142902; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XOpeZy8A3uwCctdHiax2vOOQfiE+uheW2bk2Hl1THXs=;
        b=HeExqdVOA94dk4EdotKoKDurdGP3yXwY7YFJmDOUAZx7xKtZWFpZIGRtwuTXklaxEz
         V98C3T+RtmgLE6EW5hKXiyBIsrbGwwuvmpOJA7q2JYUEhgLidMNa6M2nzUE3QLkPicz5
         mFJBahRSgyNZF7CzQQ7twLd2DMu75z6D6/ga5vcoybw5+nKn7ljaU4i/RQqcwxBJcoEu
         IO2xM5VU2H29t1a9uEbmT2RhAo9hqC1NRSx6LJOuOkUEXkWVk43zr8g1Vh7rcdvou2k4
         KvSkTLr/k+lFjrlhaaQ1nrQEgJeka0ZdiTO3nbWq01meqaEjHYw5DMNkYeYFC7Qy3kTx
         cPrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795538102; x=1796142902;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XOpeZy8A3uwCctdHiax2vOOQfiE+uheW2bk2Hl1THXs=;
        b=0zOkl7V+LJbGe/sT+P/7MmRvO6DAvRUUpUFmSUlQ6XqygfMssu/HP1UbyUx5us3Jas
         ma4/7q8g/No2SgCPf1goIlzPAI0QXDY5kBhGWfbhH/sKUL3x2monoi3A+oCVxE7RC3up
         X1NuTXgDtioiuLvluiE8J0rw3w6oCYrG6vIyZDR6c88/FFfitBTz1EbiDlZP4N5Ty2Vr
         pH53IYElTlhTYC/J3kJYpVYkz5F8CX889vOIav+xFH5z9mc4Xj4zp59NZnFMikw7dEhI
         om4STcDOKVOOHlxFDAAGRRLIEeUVEyCjJ8ep779MSYV0ZzvdAoju7Jl4hpITWcUnmhCo
         PkFg==
X-Forwarded-Encrypted: i=1; AL+hErEDj5pQBlzCRR90KfSw4HOI9912gbaLh8050N7Nu6CXMJHJ5o7Vu39vdsgTqKIfAoJTqlnjZRqOV8E=@vger.kernel.org
X-Gm-Message-State: APuU4Z9uIc/Y1uLduzOsATPP31PtnLn2SocUkbR4i8VL5wBxjmvy8CKv
	28p7VC0+QhnVl45nGSJKvXJPRayhUO3YLB5Lvr9LqPid3QdpR9bCdBQU
X-Gm-Gg: AZFdTZfJnT8ftTg6cX327B0GqQOTBl4JmkOVYkrrDbi9En9dyL8NZMxjfEZ/eSysBwa
	6xJ8Lm/3Y3MPuchto3P3zWqpsFcNW2VBApvr16aM9Ceg+999UJM3u0fZXtOjIpwnUw+11tfyy4h
	AiNZHqrlzHSFm0Yk4wsT2aQwfnZUc7Q3iZpmeWt/qIIgfK75Ctq50RLGTOHuaXN5+9pzMlo+Scd
	2wTElGpojXrdfytCK1iMxIG+yaTOUs+w5/RmARAcSCbmmrYaNaK+OI7UcVWytkxeIoKaT4Pp2LQ
	kQyjvwH6+e+DmRvMiv+/2cSpn0NzOPnRDEkdx4QS4uKCQhEu5grc6rGKjxvJxOUT+zNaTQyGibo
	SZCi6LXzlTwKbiXj/3qyIheI7mp4ofDmoOfuW2FiSGIS6QKCGYtWEIeCA2WYHT3shQFEwVjnGzt
	QDaWiToVcqfn/zOBjwqicwwI0iaDePGTiI+Y/7TBfPsnkQqpueaHbEXzypE0vygathkZSn56jIl
	pmdxZmw1ed6OGUTNrI8URCzPsYbp0t6QEduyN58VL/RjMIHAN61M44yc81lPrGcEngkdLb9A38O
	axL9H5Mb/F2RlJGgHMRnMpj8vwGC7qj15FcNqfQq9xQ6uaUHNtyzrlxU/RLI46G5UKTrqvUd/fC
	W7vqN1lphWe6IwAuaD36pQOTTu75PHRfayZiZcg5mE6OtsT9HERA8dv3lLsbaAwx2XNZzltMMpO
	DhyZw2RxL7xmKv+lqs+xkws4S4kIdHPqdjayUGPfz5ng==
X-Received: by 2002:a05:693c:600a:b0:37b:4a2b:81a with SMTP id 5a478bee46e88-3863f13587fmr14025189eec.4.1795538101816;
        Tue, 24 Nov 2026 08:35:01 -0800 (PST)
Received: from kapoor.iiserb.ac.in ([203.18.51.239])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38567abb870sm38774094eec.25.2026.11.24.08.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 08:35:01 -0800 (PST)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: liu haojie <2669793217@qq.com>
Cc: jic23@kernel.org,
	linux-iio@vger.kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org
Subject: Re: [PATCH] iio: buffer: take the source timestamp offset from all active channels
Date: Tue, 24 Nov 2026 22:04:56 +0530
Message-ID: <20261124163456.76469-1-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <tencent_1EE4F65B31B1B056C2A8FD618D533F141407@qq.com>
References: <tencent_1EE4F65B31B1B056C2A8FD618D533F141407@qq.com>
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

On Tue, Nov 24, 2026 at 08:26:29PM +0800, liu haojie wrote:
> When scan_timestamp is set, iio_buffer_update_demux() computes the source
> offset of the timestamp from the end of the last channel that was copied.
> If that channel is not the last active channel, the trailing unselected
> channels are skipped by the demux but not by this calculation, so the
> timestamp is read from the wrong place.

Agreed, the bug is real. For example, with six 2-byte channels active
and only the first one selected, the driver writes the timestamp at
offset 16 but the demux reads it from offset 8. It only shows up when
the skipped trailing channels cross the timestamp alignment, which is
probably why it has gone unnoticed.

[...]

> +		unsigned int src_loc = 0;
> +		unsigned int si;
> +
> +		/* Skip unselected channels before the source timestamp. */
> +		for_each_set_bit(si, indio_dev->active_scan_mask,
> +				 iio_get_masklength(indio_dev)) {
> +			ret = iio_storage_bytes_for_si(indio_dev, si);
> +			if (ret < 0)
> +				goto error_clear_mux_table;
> +			src_loc = ALIGN(src_loc, ret) + ret;
> +		}

This repeats what iio_compute_scan_bytes() already does for the active
mask. Its result is cached in scan_timestamp_offset, and
iio_enable_buffers() sets that before it calls iio_update_demux(). So
this can be just:

	in_loc = ACCESS_PRIVATE(indio_dev, scan_timestamp_offset);

That is also the offset iio_push_to_buffers_with_timestamp() writes to,
so the demux and the push can't disagree.

The comment also doesn't match the loop: it walks every active
channel, not only the unselected ones.

Please also add

Fixes: 5ada4ea9be16 ("staging:iio: add demux optionally to path from device to buffer")

and name the driver you reproduced this with in the commit message.
scripts/get_maintainer.pl will give you the rest of the Cc list.

Thanks,
Arnav
