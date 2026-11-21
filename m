Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795268314;
	b=lqiLoGaUjSmnwSBbnOy622Raw4MV5e6e98qWZ/pLvRfxbBEvjGPPl0+2CT1kgsQm51Bk
	 VC3ZuI//LVbof+onkERKirfm2J/HFuhH2wtkuzfjg7H0L2h84knZLAi0jv2ql5J6g7xVt
	 Bh/d6zvloKoty4nzCAv72bDZwE8AcGiP8ZtJHIp8kZs96sU6HQ9aUqpRrtgqDHEwmYRtk
	 OmgtWHqbZ7JiIq23nLhnT9OB135lcHvM+p7GR6sgIuXKRm8DEZ9hFw3hQV2MhCzzZ6Sel
	 YUw9wS4WZGI6BnVYr5zY144+lGis1tmlJZwPO8bXJccXyWZVgQy5oDiHc0j0kyH0jrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795268314;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:In-Reply-To:References:Content-Type:Date:
	 Message-ID;
	bh=2JcSkgOAc70yUl0xOGsAkRmn2yrqWyaYEB22eRFKz4Q=;
	b=JIb8/dgSNkvMXWsoMP9y8ci0ztIIzkWQSSPYHPbYciiQAy8oc/ik8vNFJyIulXtcUII0
	 F1QkcWbXZrMb4Nx8XdcR8W6aso+RpKlA+YZIXtlU3Ukj/tcTWYQgpDQSzWRPHV8haQlW8
	 Ck3zhkL/JhpaeIyJ8UX3gY5A8KMZIpy9QHK1NfA63JUOKH6XqSayZ+QOBJgPhbsal4jLx
	 gzfCz4yYumHy1w6xdyH+bjQ1gWx3ZkhDHH1hvkAIt7cgpfo2Gb6FimKSynkEVW0eot/Ql
	 8S/qkbYov6XlNFqrQwjLsVr+UUgkVrSbxuIfd3y8m24tu1t2XPb/+AXJ/6Ng/sEqIww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NiI8guW9;
	arc=none smtp.remote-ip=209.85.215.177
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3AA3606A32A
	for <linux-iio@vger.kernel.org>; Sat, 21 Nov 2026 13:38:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A3AA3606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NiI8guW9
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cdb9f760337so1581308a12.0
        for <linux-iio@vger.kernel.org>; Sat, 21 Nov 2026 05:38:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795268313; x=1795873113; darn=vger.kernel.org;
        h=message-id:date:content-type:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2JcSkgOAc70yUl0xOGsAkRmn2yrqWyaYEB22eRFKz4Q=;
        b=NiI8guW97trs2YALHBUQx5HwUu1q8e+xkO4IqLHlA4TYdHvu7rzrplXh+EWPxIKrd7
         z9pXZcroA89w541dMTytKW0zYAAHKhG2OQG79hskyNXx9Ops5jcgk48JQUCJjk8zfQ5/
         rG2dSVnCXgjNygIlV7c8yByNBjP6yj4vyKtWFGCG5VUlvRZI8Ee8H7rF9Q7BYZZCRU7S
         VE05mPAu0L6B/mejL7DpatGB2CpMceBiI+5ohCWORZ9wLBvpVugXnNIOI119HfeK4pG7
         9QmZNgHPcUEE0pf6cCpXVyoEhO0zjI5MD3Jpb9m+PYqHS3x+fJ0cERtzroQmpFsQxNv9
         geTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795268313; x=1795873113;
        h=message-id:date:content-type:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=2JcSkgOAc70yUl0xOGsAkRmn2yrqWyaYEB22eRFKz4Q=;
        b=HZ6/Cck02z7+3JnsRmGaRPv6pfE2enx61hfv13r4nJgTdNrx8wJeWbCskdwHDiA+lW
         IhgGPLPBT/+K+IZevFSMGC7ym7im0HNRKsElkfYZ1HCf2qbV/qLcn5ZHLiyC6WKlhy1r
         adg8VgX7UCwY2nZILzS2JcK2KeRAZu8amiuhfckzlVw5HOwskg70+NZbPV2kTrvfWSNx
         ox0JgdBxgh9WN2u6o3Bs5XL0QPX4DJrPmw8O8hnb8NkDDJGV4f7FPINP0PNnQnHkuIIu
         vZ8gfMVNkXfBYawZxW6IWA5BCrNW3BvXWeAJvhYc4qPrQFjV6bxKCxhaNo0YAFfeFPEp
         RXrw==
X-Forwarded-Encrypted: i=1; AL+hErEj8dNzh1/SCex8Nm4xBL5MZmyLU9iRs4jAjpLXohRhCUc52a6Z7rDRh0lrWEc5yvk52Tqo4H6O4HA=@vger.kernel.org
X-Gm-Message-State: APuU4Z/+fEyLND/v23UE4J0QEpO76p80qhyiVH++gbJx2xzCM7fbmHmN
	ad+jgI+gOhabwa+jNg+H01e551duxSX/w/h4f7SWJxz3AVkGX2VHa9lL
X-Gm-Gg: AZFdTZf+I19KotNCNNqiae6EQl22DuRt2+5/vNS5/9Cc4sfyhXut1jdS8+hlnRJmKXj
	mJbTxkc0SkZW5tn7Hi4mzkJl79umOxCxZ0OyzZ/lMwLq3i9H2CtiV1tPqAvzmmZRXSjK5Yx9Bjp
	uZbiEctir8BNl8cjgTgxYBXxeE7HoUUPxqORRPTfx2r0oafZRks5QNgPStvUIjaHC3SrMcATtn6
	3g1yZvQaJhwk7adki/iCA8WmKmoRNspAvc2ugUndUBF5FyM+XEwKofz+qZWZcBs0zVyzcxywUII
	8i983HYUEl6eIc+RnV4OlVFVZ/B4w1oQHEf1AGnv1+s9xKpSw/gp19o/pWe9w6xuSqYuXC6/TJf
	iGOXUmOuF7Db2oLI3bQewDh1NN6NoDVVK9JJP2ypOSBRPVrK/dSToh2+E4MxZzYiwTeqqWTB7Fg
	u850C8nzoR+b4cgGIH/ZA7OTPP+e8UbXkgIdsATaWql7BdNdTEd+ljgb9Xm82ITusOxBVtVsHL3
	eyYDFTclutU722Fj0kqWa4KJ2dmUr2qNCracVDzcFDlhem1WI3Y1HgB56P5GOPzwpRXYm+WwzUM
	IBZOGNqTodCfWeQ/E0jsuIAZQE/6qY5nVIANF12/Wy5rG0ajf2E4Zo1upjLn/vz5nfo59RRSx+Q
	=
X-Received: by 2002:a17:90b:2f8f:b0:3a0:d82b:237b with SMTP id 98e67ed59e1d1-3b41c938926mr3785656a91.25.1795268312893;
        Sat, 21 Nov 2026 05:38:32 -0800 (PST)
Received: from DESKTOP-UCPRL76.localdomain ([113.200.174.114])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b44b7f4899sm2032844a91.4.2026.11.21.05.38.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 05:38:32 -0800 (PST)
From: Zheng Shuhao <viennaoffh@gmail.com>
To: Ayaan Mirza Baig <ayaanmirzabaig85@gmail.com>
Cc: Arnav Kapoor <kapoorarnav43@gmail.com>,
 Jiri Kosina <jikos@kernel.org>,
 Benjamin Tissoires <bentiss@kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Jonathan Cameron <jic23@kernel.org>,
 Lee Jones <lee@kernel.org>,
 Heiko Stuebner <heiko@sntech.de>,
 linux-input@vger.kernel.org,
 linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 syzbot+fb951970a334aaff00ba@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] HID: hid-sensor-hub: avoid lock inversion in
 sensor_hub_remove()
In-Reply-To: <20261120210317.184756-1-kapoorarnav43@gmail.com>
References: <20261120210317.184756-1-kapoorarnav43@gmail.com>
Content-Type: text/plain; charset=UTF-8
Date: Sat, 21 Nov 2026 21:38:25 +0800
Message-ID: <179526830578.567.7445109567862298713@viennaoffh.gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list

Hi Ayaan,

Hmm, I overlooked the latest discussion, which caused some overlap between our patches. Sorry for the confusion.

We can merge the fixes into a single version or find another compromise. Either way works for me.

Thanks,
Zheng
