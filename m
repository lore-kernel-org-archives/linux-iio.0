Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=27.111.93.119
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794231505;
	b=fN4oY1n9RXXEtzgm/76BaP9qxVzmOHy5gUL+1mVI3RqW/WLHDayFCS3W+S0ae0c9hsYA
	 0TkJaXFdHSmDy3MTq82zUkAI1M43+Dtl2j02I9DFfUrWiqqUtUuaPMcdyCRXR2yQHec5g
	 cop4dcMN+ynCwwWPMLJjKyTNfIcgTS2D6pNl9HVDAPnLwbSa04xSwrlPntj5ikQLq8BQU
	 bklD25jenRtXIU3/ASmroizgjVczXQGN1j/ItLqLfuMPQQzTORZY2FeQYI0d4PZ6UnuPL
	 FDgafBGyZqIT651It6U0Yg5NfxbH3A0mqsJe069VNsPwgwRY7Nz2Alf5WDNlj0NkAbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794231505;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Content-Language:To:Cc:From:Subject:
	 Content-Type:Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-Get-Message-Sender-Via:
	 X-Authenticated-Sender:X-Source:X-Source-Args:X-Source-Dir;
	bh=uvAYekqH5PZ/S1k8d5HRoKzaRz5t9ww/DlktDgvYlvo=;
	b=DWEA8K0r+0a47FdxYcza/learbXpAT0ZO65VxseLSk9i4am5IYPLrhetcdEEvlvVm5aU
	 0gjsIwZV9Zhv/uk9jZvsFDwKGx7KgNWyyY3cQQSFZfuynA2p6i5iXU1v4hXlX9KS8HCBd
	 Y5ulmvV7wAkjIUIJJWS1E6QaFyr9bkbrc6TqWEcmTrKkCOHANlQl/a5yvRW/cYu/DRT3F
	 JU9HoxkMkPQeD6i6781+FQEkM0I+9tvu2n6QM6QWy8NGgssGxWs4csV/PewuldIF46LxZ
	 KNtottwtPHiGMP+odSGyf1q9zT4qu/Yy61+lFarTsfzL6Y1bnvR5oQjFyNznu7e0xvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=advisoft.co.nz;
	spf=pass smtp.mailfrom=advisoft.co.nz;
	dkim=pass header.d=advisoft.co.nz header.i=@advisoft.co.nz header.a=rsa-sha256 header.s=default header.b=LP37ul1t;
	arc=none smtp.remote-ip=27.111.93.119
Received: from mail-p2-f3b.ipv4.au.ds.network (mail-p2-f3b.ipv4.au.ds.network [27.111.93.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E8D606D821
	for <linux-iio@vger.kernel.org>; Mon,  9 Nov 2026 13:38:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6E8D606D821
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=advisoft.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=advisoft.co.nz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=advisoft.co.nz header.i=@advisoft.co.nz header.a=rsa-sha256 header.s=default header.b=LP37ul1t
Received: from server-72-r70.ipv4.per01.ds.network (ip7ac97cc8.ipv4.syd02.ds.network [122.201.124.200])
	by filter-out06.au.ds.network (Halon) with ESMTPS
	id d0ddcdac-dc42-11f1-99a3-a737d9061d8b;
	Tue, 10 Nov 2026 00:38:15 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=advisoft.co.nz; s=default; h=Content-Transfer-Encoding:Content-Type:Subject
	:From:Cc:To:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=uvAYekqH5PZ/S1k8d5HRoKzaRz5t9ww/DlktDgvYlvo=; b=LP37ul1tuVHfcbW79rRKh9E1Ml
	nNGc2IZPQA/k4nuFTGZYk9BbFF36mDh/XRrOmnnlJaN3rjDdjD66qEjBePFsWBDARlJ/wL1mWM1Mu
	XBLLpueAvw6bckdzm7NIzaUyqydIFh6z6rM+KSeHBi/eMxnovLeVGoZUQb63rzebV+1GO5uAFtHgM
	Aw5z0z/yVygJr9B/llzij4TOwem4A1G8fD7LIqFqF0IkBSkeN01d6iQgPaIk+ZX/2DNpUmKMW2Cpz
	eoHHVRYg11GnQxQ8KawCYGjBgooYii0wcf51pW6yrwRGbxovvZ0khA+awkMII5D3uUEAfDVT6B+fb
	ZEn2Z06w==;
Received: from [115.69.178.245] (port=48171 helo=[192.168.2.212])
	by cp-fp09.syd02.ds.network with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.100.1)
	(envelope-from <phil.williams@advisoft.co.nz>)
	id 1xQPZf-0000000AXH4-1jP5;
	Tue, 10 Nov 2026 02:38:15 +1300
Message-ID: <a3a00c75-c830-4d1a-9a89-dd55641a422f@advisoft.co.nz>
Date: Tue, 10 Nov 2026 02:38:14 +1300
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: mario.tesi@st.com, mario.tesi@st.com
Cc: jic23@kernel.org, linux-iio@vger.kernel.org
From: Phil Williams <phil.williams@advisoft.co.nz>
Subject: [BUG] iio: st_lsm6dsx: hw timestamp gain is 0 on ISM330DLC / LSM6DSL
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cp-fp09.syd02.ds.network
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - advisoft.co.nz
X-Get-Message-Sender-Via: cp-fp09.syd02.ds.network: authenticated_id: phil.williams@advisoft.co.nz
X-Authenticated-Sender: cp-fp09.syd02.ds.network: phil.williams@advisoft.co.nz
X-Source: 
X-Source-Args: 
X-Source-Dir: 

Hey Guys,

I ran into an issue where every FIFO sample from an ISM330DLC came out 
with the same timestamp, so our attitude math froze the pitch. The 
accelerometer and gyroscope values were fine. I've patched it locally, 
so this is just an FYI.

Make what you want of it, but here is an AI generated description of the 
issue:

Commit 8abbf45fcda0 ("iio: st_lsm6dsx: Fixed calibrated timestamp 
calculation") drops the timestamp scale for the older parts in this 
driver. Stable backport 981f3da383ce is what we hit, in 6.6.142.

st_lsm6dsx_init_hw_timer() used to do:

     hw->ts_gain = ST_LSM6DSX_TS_SENSITIVITY; /* 25000 ns/tick */

That commit deletes the constant and reads the gain from the per-chip table:

     hw->ts_gain = ts_settings->ts_sensitivity;

ts_sensitivity is only filled in on the entries that already had 
freq_fine (LSM6DSO / LSM6DSR / LSM6DSV and that generation). The 
untagged-FIFO entries have no freq_fine register, so they were left at 0:

     LSM6DS3
     LSM6DS3H
     LSM6DSL, LSM6DSM, ISM330DLC, LSM6DS3TR-C

st_lsm6dsx_read_fifo() still does:

     ts = data[1] << 16 | data[0] << 8 | data[3];
     ts *= hw->ts_gain;
     iio_push_to_buffers_with_timestamp(..., sensor->ts_ref + ts);

With ts_gain == 0 every sample is published as ts_ref, the 
CLOCK_REALTIME value taken when the buffer was enabled. The accel and 
gyro values are fine. Only the timestamp is stuck. The raw count is 
still checked against 0xff0000 before the multiply, so ts_ref is 
refreshed when the counter gets there. At 25 µs/tick that is about 7 
minutes. The driver comment says 1.638 s, which is 2^16 ticks, but the 
test is 0xff0000.

How we found it: an ISM330DLC on SPI (whoami 0x6a), on a Toradex Verdin 
i.MX8M Plus, after moving onto 6.6.142. Userspace integrates attitude 
from the delta of the IIO buffer timestamp and treats a non-increasing 
timestamp as dt = 0, so pitch, roll and yaw froze at the first sample. A 
strace of the process reading /dev/iio:deviceX showed the xyz int16s 
changing and the 8 timestamp bytes identical across samples. The same 
binary against the previous kernel, which still used the 25000 constant, 
did not do this.

Setting the old scale on those three entries fixes it. freq_fine stays 
unset, so the trim register is not read and the gain stays exactly 
25000, which is what those parts had before:

     .ts_sensitivity = 25000,
     .ts_trim_coeff = 37500,

After booting that kernel the timestamp bytes increment and pitch tracks 
the unit again. The entries that already had ts_sensitivity (25000, or 
21701 on the freq_fine 0x4f part) were left alone.

Fixes: 8abbf45fcda0 ("iio: st_lsm6dsx: Fixed calibrated timestamp 
calculation")

Regards,
Phil Williams
Principal Software Engineer
Advisoft Ltd

