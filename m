Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FAD1325495
	for <linux-iio@vger.kernel.org>; Thu, 16 Apr 2026 18:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776363766; cv=none; b=D7Wky9JZ1RCdPhZPaVHSiLwzYu+rO1PwVEXq8oiNmybcsGBT9KTxuuU9gPDiloorfMvsm1Sa/rdm5HMm8lwWqsgv3h871j6/ASL9aZXo1NHyDy3AbPWgnd0KealkUWwNGLWZMZLmtZ/d+1Oj8NRGnnz1FhDXziQQDiYT1/qy4ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776363766; c=relaxed/simple;
	bh=rl0pPZY0En+smo8Tbp46Hfw0Phk/mYxqmZrNc9qEMo4=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=RvrFADbvLg+PYHcSUIkeOQ52W+W4mhhg4flNnu7aGtZYI1uF8FUlBUXmLL4hX06lO25sNzcjLzYYKI+YjF80qLeMULuZTQ2fv39hf7qymgi0IEn8T/zrOz8WWNBuhai1aroqG2mJBaO5h8DHRVuUySbK81M9EwfNL9JNDAuHsfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m6virisg; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m6virisg"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2b45cb89f7eso32946515ad.0
        for <linux-iio@vger.kernel.org>; Thu, 16 Apr 2026 11:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776363764; x=1776968564; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rl0pPZY0En+smo8Tbp46Hfw0Phk/mYxqmZrNc9qEMo4=;
        b=m6virisgzkUSkf/6kjsi1au56bZApaub2Z3KAM0rxiOR0xR38Xiva+CaEHnDEW8uvj
         d+7smixvCtUFSo1+BANMjdJZpaUwoyX39fO5jh7r9DCOrI+Aok857K7TM4Arqhtm3MHW
         u3w3uvUtLc6YH1rRP4gQd3jak55V+d4ZGt1n3ivA3vwCsUSWGXTq24POt4hUjXV91y42
         GPxPhS15zy0+ZyzJsRRZV8j/LVnNNwtUlyWfXXekMara1UnnyREb8Sen/qZpqvdCnOal
         kQzT7G8T7bPqBKtwakTrbvc7mc3os2V21DOREbDZfG8jP3ng/uh/vYnSgoQfsQc4/ptk
         YrqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776363764; x=1776968564;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rl0pPZY0En+smo8Tbp46Hfw0Phk/mYxqmZrNc9qEMo4=;
        b=QtO40evm7PP9jq9anmJIMlvrE2jyz7cVRooK8Rq3ffLsOCfZ90G5+am3/QULL6WssA
         nDOsXEeRtp5RhR6/4ubLahrMDk5zV2XxPtpC9aK+XLLpwSIDfO3v/mZUUtLVs0kMFncD
         CJi6ijqSIY+Af/DIvamAcBUVuzEMD1ELoxEGp2BodIgA6mYbIDBwhzr3g+JA0VuN6g4J
         ybdHFxjM13EUPlr1gRfAXVPKHTGMKmYEETJ5PdLW17Vk1N1FYPNId2iqcbRleN+qWuX/
         61TbS/MqHC9BEQYD+cz/FK7M9Yj9PYYy68NWEwW1HpEyNfJ27cmra9sEx4NpmHUH4OYG
         irSA==
X-Forwarded-Encrypted: i=1; AFNElJ9yeULna2q9OUlq3un0lLxm0Yf1p46w+WxBFc3snVuhZ4EQkapCxfZkbGNWAbOL8/1tLre3ba6Rp6Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqWLHVN7dHESy5PHI/BzoaZvgO90umVEFbsJ/v0BSJ1vNK1Pja
	zAx4HPwNl9TSvQjfL7s1IhrDR7eTAagkskUSpPo8ZchXOLvaVzf0Sbe8Pfqg0wsP
X-Gm-Gg: AeBDiescLPMTtHmTycyFHK8KPSvNuqRea3FK5RHzatoyJza102RiTkHU30xivaN6e6v
	GWMRzJpvzH2lMFAdJHGBltTLkqaIMRybv1ZNI73dJ9SgZAtQMN1BHeEdRCAcF6gj9sM306Fgq8t
	TBG+yBUpmzcp/OlnFBSZu4blFk9NJTeY5l7Xq0GNopg4OEZRXLsfk6LMqJqqTdqbofOO+WHSAsC
	uUnBp7PuItB99xsaTSt2ecyhpCUGfZX7cmNDdYfmGGWy0L6JvDq3IcTiJxVKQfHu/SqZ9PpB8eG
	bDKBTvr15/tw+BkH3/SrCaOHwIYhYNWFNxvW4LlNbQCtEA0VV/KWHD+BYY89uUaqqFSk0Wv2iWN
	Vav9KAGgrrleHwDF3yMbL9kcdEYuon2AsRl7YM3uBojHXtmzzvuafsefZzeOlqnE4QLa4UWfmvK
	3pbbJOkauFyp7CS5Zn2Ihs5nR+1K8mS91MfT9k0E5lBgcQSqwVqFUUYEPV7A==
X-Received: by 2002:a17:902:7207:b0:2ae:ba5f:3ac3 with SMTP id d9443c01a7336-2b5f8d3fedamr698925ad.2.1776363764211;
        Thu, 16 Apr 2026 11:22:44 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2401:4900:c028:d5b7:86be:2182:cc81:291a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b478109ab5sm62001715ad.19.2026.04.16.11.22.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Apr 2026 11:22:43 -0700 (PDT)
Date: Thu, 16 Apr 2026 23:52:38 +0530
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
CC: lucas.p.stankus@gmail.com, lars@metafoo.de, Michael.Hennerich@analog.com,
 jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_2/3=5D_iio=3A_accel=3A_adxl313?=
 =?US-ASCII?Q?=5Fcore=3A_use_guard=28=29_to_release_mutex?=
User-Agent: Thunderbird for Android
In-Reply-To: <aeCcMWmLF2UMfZHa@ashevche-desk.local>
References: <20260416051631.551250-1-sanjayembedded@gmail.com> <20260416051631.551250-3-sanjayembedded@gmail.com> <aeCcMWmLF2UMfZHa@ashevche-desk.local>
Message-ID: <5A01262A-8FD9-438D-801D-C6DE2AC232F0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 16 April 2026 1:52:09=E2=80=AFpm IST, Andy Shevchenko <andriy=2Eshevche=
nko@intel=2Ecom> wrote:
>On Thu, Apr 16, 2026 at 10:46:30AM +0530, Sanjay Chitroda wrote:
>
>> Replace explicit mutex_lock() and mutex_unlock() with the guard() macro
>> for cleaner and safer mutex handling=2E
>
>You missed two things:
>- cleanup=2Eh
>- the patch is already in tree
>
>Please, always use the tip of the respective subsystem treer
>(it's usually iio/testing for IIO)=2E
>

Thank you for the input=2E

Understood, I will always use iio/testing for further development=2E

I have dropped this change=2E
