Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795414711;
	b=oszayDM7QsiZm/PPKcvZ6X+qHM36vb2FR3b28/eamIG+4/3e8nlPRKlpZDMS8hUCgKXg
	 kyI+mGoVg2Eqi09j7Y0BJihNLwjfRktbnD2zavWdS++daTZogrxXTsZ0PurQZGy8Wikda
	 ThgMMA5xaQjOk0I9asljT//KlNH4YaNW5ZBTz+OkHRyKcFFLa67dZWMvqc4yXOOLD3buj
	 4BM9dEeWAH/CSW2vjdgCjxQ8UfMtwWwb64uY2QkpCECyg81UL6PMQ7/de7Y0QIYaZRdDT
	 8w1osnWOokPbPJu1otYMhBrMyi/ymkf9Jj/1/oiiLU8YrrRTh48gQeYY5CFssqZoGZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795414711;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=dLytYQ07FVJVySJIOlerRAcLdDVChLBLXXS4O66TYZs=;
	b=OLYuCl+1j+s4klxmN028fm/aAR+RjmzO1MT38MK6nMfQq4whoEybUHIpT4bP+HsIx347
	 MsE6BqW/kpolpj3vo/VKLJi1PFABxqFyKPFB2LpCuyNewn4Sx7FeQeKkR/i+ApfvuSR5/
	 XOprOw+tgm7N6iHNo8Bvj0dbzX4sgX777wGy0MxuZwXU4f+sEX7jxJr08WycfinQX+9t1
	 0Sgw4jH3ybEHKO40eNlE24DhxXGldeHfRgLtbNVYJ0hmCsvf10O43vwqv/e6X1jZTlcG2
	 Ux8MDkap9EtQh4wJyCMZ7OObrYtyR9O/8uDsGR1C5rxJRyBL4a3mIEqYS1MC40AUoJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FEAfsgvo;
	arc=none smtp.remote-ip=209.85.210.174
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1459606A31A
	for <linux-iio@vger.kernel.org>; Mon, 23 Nov 2026 06:18:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1459606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FEAfsgvo
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8b3577deeb0so1249826b3a.3
        for <linux-iio@vger.kernel.org>; Sun, 22 Nov 2026 22:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795414710; x=1796019510; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dLytYQ07FVJVySJIOlerRAcLdDVChLBLXXS4O66TYZs=;
        b=FEAfsgvodyRhzP/vHapBg4sJcaEX4S3niiiCMjiNzeMaG0wKjv6kKg+pOyWz8lDh6j
         9A93s/4Mhg0e1nDlV3auIkYILrpcWTaluG8DGKZ3nrg7v4Ms/3uAt/pPTF4cTDQ5Z1u4
         s79exU2c8GhZnd8pP92AmcZn2/rMSz2294/8LlYqkD2MYndip9Cw+UMpBDO5a2U9mspR
         V3V1BmUT6ceAbBpLzd3SxPpgpBAKOtzKWT/vtUNno5MaGBdS33N/KFHq1b3n0MG/QQIi
         r4RRMQ1F+oNPKVNUvT5Jqgr1BFFJBcdvamZd/7CxnuCnghSf9YEBxhROgB9LShA1HVo+
         TerA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795414710; x=1796019510;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dLytYQ07FVJVySJIOlerRAcLdDVChLBLXXS4O66TYZs=;
        b=cV0StHYiLEFVN2RSXseOlnCEKsdNdM57Jqffzz3Lt/mvTgU1T6OWljHbNDmJcY75M/
         87JExJcQxLOUwEcULbXlQODDRAaZT517WuW913GxIUdaDNDphT9TJ51xTWpbasW0AmdX
         X2uCTjPJnkLQ845vus6A8GgNvhizYDlNdn+fkjM646l3YB93iAKQZCjX5ZFRL9TlN+3n
         3wvfaJp3zVHF1upILPTC7/Ofv/RDAurc7O9Xswh83MFMXph3jxsSod1NfnIxDK7AGskE
         3Ux9kcoWMn/dIBlnvevfCcw7qouEgntijHmjQ39Gi8SepcgLK/ffLQxFM1TWIRTZZTNR
         paug==
X-Forwarded-Encrypted: i=1; AL+hErFRucf3w+/OScAwp5sulX50aT+6SRrraaNoFWEPs4/W+ZA2B4ve6GAt72AdPXFSrqnVPxsx6ohLf2E=@vger.kernel.org
X-Gm-Message-State: APuU4Z8DO6YpvXft0/ApqfjJ2q6348ksF5E6vFfXEV/bS+jjlIi3iefY
	0qAVUjw5NBVAiDrcHJXlxT24cfc+5xzGnihro7oCyj+ziStro4Uv0JZP
X-Gm-Gg: AZFdTZffjZf+JkymZL+OTaLeUlCThdy+7e2PK6a+ISYirwmXujAq0yeZY8TRKzQ0GUX
	I6U+5xOZvJYekUyblu1Nw5j4Jrsz6YEVgW7KVL2b2q+buk9RFMRYVLtoGvDSfZjxuhX4eKrsCat
	4NIfeGdfpkqexo8zhFamWEa+/DK3Pptf1hWblzBKqc0Ux1Vpl+u9KKjicsw32ZdAK16yNJZODDK
	J1BHLlTBbI6Qsf5ceE5sPgukgsr3sjyrL1grWbxMoTRWA1UcFB+zoSOwZISVJD532BAXPEO2ivG
	3t5vAvLGlkVhJigkkN6aa/3d7grJ0BPcADtgoxUCRm3ZpICuX88CsJLksrerltwBZkyJxNsbrdP
	5aq+iPYslz1Tg3WzkT8vna6ZXsDTbhfOvT5S52sxkLMkQ6f/UmLBlN3gTdJXUcB0Dbz4WLlIK1y
	MGSq47tBRZIFL2DujnNkxO45fZ8OYcyEKRDVzBz/1cweZJkA3rBohtfIDIwOTUgN21W4vJ1RbFQ
	YEjAkzYpLIPK+BKt/ooR3rNHDfqgV7ljk+EwJbPZ1pG1bBV+5Tt6EJ/o1JA9NhuvXJUDhpdNxyy
	w0jUJWDrtkP/dsXQnzPdQ7T13TD67wmu5eGbc6EfoBkRz+Ud
X-Received: by 2002:a17:90b:224e:b0:3b4:22d:e066 with SMTP id 98e67ed59e1d1-3b41c7d6061mr9586446a91.5.1795414709920;
        Sun, 22 Nov 2026 22:18:29 -0800 (PST)
Received: from [169.254.42.106] ([113.200.174.114])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b405d63728sm20555357a91.8.2026.11.22.22.18.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 22:18:29 -0800 (PST)
From: Zheng Shuhao <viennaoffh@gmail.com>
To: "Zhang, Lixu" <lixu.zhang@intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: jikos@kernel.org, jic23@kernel.org, bentiss@kernel.org, heiko@sntech.de,
 lee@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 ayaanmirzabaig85@gmail.com,
 syzbot+fb951970a334aaff00ba@syzkaller.appspotmail.com
Subject:
 Re: [PATCH v2] HID: sensor-hub: Avoid holding spinlock across child iteration
Date: Mon, 23 Nov 2026 14:18:22 +0800
Message-ID: <179541470215.18860.14575261868309740807@gmail.com>
In-Reply-To: =?utf-8?q?=3CSJ0PR11MB561395B8C8BF1B839137926793452=40SJ0PR11MB?=
 =?utf-8?q?5613=2Enamprd11=2Eprod=2Eoutlook=2Ecom=3E?=
References: <1795161418.hid-sensor-hub@viennaoffh.gmail.com>
 <20261120135005.566-1-viennaoffh@gmail.com>
 <573f3eb75601c17d6e766fc47a7cce1bc2274998.camel@linux.intel.com> 
 =?utf-8?q?=3CSJ0PR11MB561395B8C8BF1B839137926793452=40SJ0PR11MB5613=2Enampr?=
 =?utf-8?q?d11=2Eprod=2Eoutlook=2Ecom=3E?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

I'll do that. It was only after your reminder that I noticed Srinivas's patch=
 had landed in git history just a few minutes after I sent out v2.

OK, there may have been some misunderstanding here. I developed my patch agai=
nst the baseline kernel without following the discussion around patches that =
hadn't yet been merged, so after sashiko reported the null pointer issue (htt=
ps://sashiko.dev/#/bug/linux-23655093-642a-447c-b416-776e47c98d55), I submitt=
ed the patch directly without giving it much thought. Only now do I see that =
Srinivas's earlier patch had actually already included the NULL-dereference g=
uard. It was all such a coincidence, and I got confused =E2=80=94 after all, =
I assumed the issue sashiko had just reported wouldn't already have an earlie=
r fix, and I also wonder why would that happened.

Anyway, I'll send out v3 though it may not make much sense. I apologize for a=
ll the trouble I've caused.

On Mon, Nov 23, 2026 at 10:39 AM Zhang, Lixu <lixu.zhang@intel.com> wrote:
> Hi Shuhao,
>
> Thanks for the patch. This v2 does not apply cleanly on top of
> hid/for-next due to commit 41cb3076a221 ("HID: sensor-hub: Remove
> clients before stopping hardware").
>
> Could you please rebase it on top of hid/for-next and resend as v3?
> I'd be happy to test v3 and provide a Tested-by tag.
>
> Thanks,
> Lixu
