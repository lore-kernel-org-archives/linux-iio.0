Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794942638;
	b=jMJX0lCM4+H3eNFFehrQEjW+s4yNuZD1dIuZjtBQzGpVk6TfNqFclWS1iVsEPndjn3JQ
	 xWvyV+0+i+a1p/ePs2QHvILZUXcLnUUkReVemYg4h4aSu46/NR0fv8epkdQ4HAzyE8NAS
	 BKx3WN8HIdMrClhQRZ62Ef56dCdqCQuVMOVTO18ct6/foqpD60GgaDM6H8dJLMoLbSPqT
	 /U9AWDIZreGNuljLH9K045gUJVkz5AFeygPzFotZwKakeLMHdpzDJlA/SliBCWI1eqeOS
	 QcWSTT3TQ3QzKAi3/CXl7UqjpLw3ZkZwMj9h+45Q+X+tYdSwyCHxH99gTm+gLSUy8Ag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794942638;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=2xUd7HOwARMUF3AW3gwuiPFH+PCIijhUinHxFgOMy1Y=;
	b=AKwkZAy1ZicdotY59dy+cApVHtDA8SRkYQLFPFDBLvwd5/lKQXqzI80lt12wv7CJdcwQ
	 3WruDhjBc/IcAz/A4syMorU9qkvrfjYjjw6Drudgu4yBxX8mVdIxp/4skrO81rcvU0tw1
	 k/CiuBBFCdT37ZIImFFzKAKl4ZD5zfUWvrqBUnAZ++7yWym5dLtSa7nb3C6gYwUk483aS
	 zNSHrY6qbMqU4Hsyj771jmWb9YiQLOTtxEtvHNEPV7I8aQiNLnlwWVb/fSd7nMJktRHyZ
	 YxjG+zT4aPHNnrOLFDCpK93LxxgvwKkd8laTM8TwfphTM3Owv7jLTsBOUXYGFe/hykg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Xx+fpoRn;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DBB9606A32A
	for <linux-iio@vger.kernel.org>; Tue, 17 Nov 2026 19:10:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3DBB9606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Xx+fpoRn
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-381d542bc29so428621eec.1
        for <linux-iio@vger.kernel.org>; Tue, 17 Nov 2026 11:10:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794942637; x=1795547437; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2xUd7HOwARMUF3AW3gwuiPFH+PCIijhUinHxFgOMy1Y=;
        b=Xx+fpoRnpCRdOqze3+No/nxk+FWb0wxwuM6eu/X23MEs+aFeROoMZIO9Wy0FB1MWud
         l/SHnHAnF64alqRTwLzL6wfT5yKfPlRPAYl/6X45Xqhf072qRA2390XHDJQssuO1Zsmd
         GFXTGlvCWIQ3ytqOl/7D2fI2Y8g5/ma+qSi7tC8uMPfSItB62y8QaWAKdeA6iiSRNK3r
         OSBf/tr6CFiBmM8I1S3gFiaA7z3ZYSA3cGbaZtk7O+/Do9//5V1WSnUza2rvP8DzaaE8
         +G/3A1n4BAvH32ov25k2YLclpZ5yN59WfcrlZFAg9BFUuNfU8tTzejq4TQWi3ChwCQXd
         80Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794942637; x=1795547437;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2xUd7HOwARMUF3AW3gwuiPFH+PCIijhUinHxFgOMy1Y=;
        b=eXnodf+e4RUYAMswAZdxDhQYEMs7+oIlz+DBWM22/BVpoPeOUMzHwk2NmzUbT08UHY
         KJ9XqlHGxxcDpZUkjgOyVGwSvSOWy/kM5jdeJWo48DxUzPbEexnIg1cdAyTz/cOg1NZN
         eQpT+PnlCuifUkUJ46CGavjJoEcUqjRFUphgk4HEDtn6VBs1Ri+QwsmcpiH7frCecy7A
         gNHQ8RXS4AXZmCaaA9MeWIbQqGSz2VQPAg6i9Z7iJm7vwweVH7AmaYl9c7O8nNUUc4A6
         DppKp8BP9oL/E9p3xPTxe4tWVi59YGcVL4LbySrpTuZ0N1IDi/YVleOIKJAakYMp8FGh
         hSrA==
X-Forwarded-Encrypted: i=1; AL+hErFCO40qY2NRghjKsJ3c+Un3d9FpFM1gJsb4YuocZ4hHXadll5NkCKPathlIChCDjCXgUmeOYPypiW4=@vger.kernel.org
X-Gm-Message-State: APuU4Z887XecIjNz2HfwjZPSYRFB/5Gu33vUbxkDxNu4KfvOKbC0Lk3E
	PHysIZdUoaYquPogDUG8I1hnGLnlXkmBLhvyLVZZUgMz5dwpWjxd+jit
X-Gm-Gg: AZFdTZfZk2UunpMgs6TMjAwTMpwRAF5IwYOs4EIgP2r+2YG0fYVBdZmqFa8Kk8AwqS0
	T+y95QZ8FxDiAhNRkE0kc5kOPwqs5KDPrLEwvNAj0P7vRoZuJpA4FU8BMRpUS/y/MlsWom7l+3E
	j1pL/nPMa52iSLd/DSlp56N++qnOdISXYWINkLxxmYjRPhQHTXLNmH2MUkiPR+rC8n6iKoZReUi
	qaSMvI8zx751g4/+IEl7ZeCVT5bvE6jGRLBYWylt8hX2O/MQX5dQb7k80b6B6MXwwVvfg/zhHg3
	KkloPZJsi7OtTfQalrhgRVzl/h2IrMRSiEvZNbXqKGRcCyAbSoIctALDEtSnOyD7yT7sLFuwLjA
	dUGV30imCk1/2T56vtNNY3TcuF2PM9DHNeWwlw1aVquErHkouDDLfEn/FFj/D6+gWBJgVnbXyaf
	B0LqT7T928/DaJ24dXV8tKI9N6E9ym3GrDHQpU/v5aVYX9bU/5km1eu7LO9HnnTZyrpEYfCqMVY
	ve58p2WMef8PJ06bnETaJBt/Bw6K73MGVsxcOP9T6gLHBa5EThWCm7UyfBaElEhZ+28/YAKJPmz
	XyAGOteYAXPEMvEyDkLV62pmjNZvgNbk0Woao7TpSmr8jaN5jT2x1adOByQEkXid3fp1hvRieqi
	EEEumS0meIHvOpSXAaE/rlwSHudNQVw2ltqtDXINye0PkdnJ+qBZ9DYRkxf9PWaiCaKN9RAkxwa
	K8I3gzY/IIWecMIAm4dNQfSGzkgzZbpOrJiZzoxj/d3Q==
X-Received: by 2002:a05:7301:fc13:b0:36f:29bf:4326 with SMTP id 5a478bee46e88-3827abdd3e0mr382876eec.0.1794942637141;
        Tue, 17 Nov 2026 11:10:37 -0800 (PST)
Received: from kapoor.iiserb.ac.in ([203.18.51.239])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-382a172a0a8sm67255eec.0.2026.11.17.11.10.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 11:10:36 -0800 (PST)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Gwendal Grignou <gwendal@chromium.org>,
	Stephen Boyd <swboyd@chromium.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] iio: proximity: sx9324: fix proximity threshold writes
Date: Wed, 18 Nov 2026 00:40:29 +0530
Message-ID: <20261117191029.83901-1-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <avyj-lOGvj04A_Ak@ashevche-desk.local>
References: <20261116205320.26070-1-kapoorarnav43@gmail.com> <20261116205320.26070-3-kapoorarnav43@gmail.com> <avyj-lOGvj04A_Ak@ashevche-desk.local>
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

On Tue, Nov 17, 2026 at 08:59:06PM +0200, Andy Shevchenko wrote:
> > For odd r the read value is (r * r - 1) / 2,
>
> No, it's r²/2 but in integer arithmetics. That's why for odd number squares
> it gives 1/2 that becomes 0.

Same value, but your wording is clearer. I'll say in v2 that r * r / 2
rounds down for odd r.

> Yep, what we see is off-by-one for full squares. This is because division
> by 2 in integer arithmetics makes it floor number. So, what you want
> to have is a correction for all odd numbers.

> And here I would rather use (val % 2) instead of 1. See above why.

I don't think val % 2 works, because the correction depends on whether
the register code r is odd, not whether val is. Odd codes read back as
even values too, as in your table:

	reg	read value	int_sqrt(2 * val + val % 2)	int_sqrt(2 * val + 1)
	3	4		int_sqrt(8)  = 2		int_sqrt(9)  = 3
	5	12		int_sqrt(24) = 4		int_sqrt(25) = 5
	7	24		int_sqrt(48) = 6		int_sqrt(49) = 7

With + 1: an odd r reads back as (r * r - 1) / 2, so 2 * val + 1 is
exactly r * r. An even r reads back as r * r / 2, so 2 * val + 1 is
r * r + 1, and int_sqrt() still gives r. Checking all 256 codes, + 1
round-trips every one of them, while val % 2 still fails on the same
127 codes as the current int_sqrt(2 * val). For values in between,
+ 1 also picks the largest code whose threshold does not exceed the
requested value.

> For the write part (the negative is problematic only on 32-bit case IIUC)

I think it is on 64-bit too: val is an unsigned int, so 2 * val wraps
at 32 bits before int_sqrt() sees it, whatever the size of long.

> > 	reg = SX9324_REG_PROX_CTRL6 + chan->channel / 2;
>
> This one is not used in the conditionals, so the new check may well be done
> before it.

> > +	if (_val < 0)
>
> Checking _val after assigning val to it is confusing.

> > 	if (val >= 1)
>
> First of all, I would drop the '=' here.

Agreed on all three. In v2 the check on _val will come first, before
val and reg are assigned, and the condition will be val > 1. I'll make
the same changes in 5/6, which has the same code for sx9360.

Thanks,
Arnav
