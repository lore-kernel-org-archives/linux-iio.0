Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54EED1A9FA0
	for <linux-iio@vger.kernel.org>; Tue, 21 Apr 2026 02:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776737022; cv=none; b=En86ozHJgxUWCVOyPXDUkK/J0ZhHWnNkPWanjUclc+ejUJe0rC/JQSUm7rdP/Z9M1mzCw0XB+SEr1H+aIRzHY0gQE/HOXj7jtFz67hqGDEvEx0CVxi9DL7UdC9H+3mJfLtYWdiPhewxCqppxLEYSE8mZ6dxZYzB3Ylp9HqByrvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776737022; c=relaxed/simple;
	bh=/Dv8cvp4dyydKcDv8Uj6PeNSb/LTw5WxdHCmfDaVWQA=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=qWMOjNDRKkbjft5QERG+EgdVh1P4LD3XuqJpOmE4vNJMqZJBwenhFz8vno8GjN7gbrFRMbv8MPo9v5GEGYQ1jwbfxJ1W+A5sZJPB7owxhbyARyvk44qLNtlCeTSZwrkiHY4B5O49aHQxtmxJnl9rlHv8QDGaBW+3IDb/ubU3N/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q4OlvWCY; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q4OlvWCY"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-82fcd0aa2dbso87787b3a.0
        for <linux-iio@vger.kernel.org>; Mon, 20 Apr 2026 19:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776737021; x=1777341821; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hy29epMyfsYUurE4pd5MGoUMpPF9IzGtxLeHSnRuzNM=;
        b=q4OlvWCYyYoaxhpQOR1fMVaxFiQ79R2yabBUFv/tnJot0rSwfrjWTk6kkGQMNXoMBB
         yNkKbcRA/vX4voICkcScVWJo+51e2p/zDzRBt+/K5riE/knxSNaeTW4F1n/EvEXzlGG2
         EaURviheocga7X61wFnEQapx/OunM5Q1ISAW7DeOF+lHp40HYah17plAta/QFd2pt7i2
         VvO9WcLRMRO+iWW0JPODnp+Zfeh/mB3eBKNry0DAGsakJGkbnsIGQ8r2I9QzkdbLhGWF
         rS7LWEUE9RFD39hfVjWN8QinD+QYs31oa+9/vs11cA7m9hFD1K7lQl9s5NXrTh9EEHqn
         dZ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776737021; x=1777341821;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hy29epMyfsYUurE4pd5MGoUMpPF9IzGtxLeHSnRuzNM=;
        b=RQYokRcdWRk12b/wLXJtqY877lOvOHGZpjM5jUhxxqgfWMMOje3ROmvd7UlalEBtFe
         w0MgoHpBTCfzdOiMPHW0s3/9KszeaDcLS7sqU2GnyyYIYXrIewesSCEzYMZHL79sOafv
         Ra24UWuGI92+8wppWLLRbWh8e/c7mwkPE/5qjGoQmpkPK/S9YpaPFzOXewd+7xcC1NJl
         PCPVn7nhl7zvWOVorGtkhiZITmGeCUDEvJ7SbMeHj7W9m1vJzp3QA3pVPzcm4x/2GwgI
         e8dNvq7XO3yikitrkLwh6c+NCsE43EVEzE5sOw1zlT67ODiIK0Igo7swfwRhArtwswAE
         ug7w==
X-Forwarded-Encrypted: i=1; AFNElJ82MsmbVboAHZrKpNtF/StcfMyFxHRA1r+ZouAvhRBOHLBju0wu18haIZUe07oXohKjRzcfooIxVjI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNhJy4R6mMMqASGrqHxQJeFB912PgeIXx3vml4+fRglo/q2nGj
	cfZwFeeEf6fzqdBhZAxeScZcmHyFeZa+EjIHVRpvokbMFdxSB403VXp3uF7enw==
X-Gm-Gg: AeBDiesOieGRNmV+QMH7irl8+ZYVV0qkRC4skVVij6v/BYr1oE742VcbMr892/6A7JF
	bYshec441k9VV5H9aPQ7ZiEadBUWZU39QawlWsMnjTsRuw+yenEIK7i/Si8uJPR9zlgdA33cv/y
	LKIZWy4BuRkaZCb63jXf/Mx3g6xe264gVzRjwHAjGUyILM3PzL3DQOYi9PpRHxIMzzW56O8f1S8
	c2MtA2EJsl/R6eVSSgceiRX0kA3CpImMfRuWxOmRBnrITeQ0/nWBbM7kRAUeas/bi+RNTKM2VcS
	/O4jXsy0NzMtMcnbnCJn1F9M2h1xtrwJrhlZfokdobMT0lhoF7FVki2yCNxTJJoNTiWFiG/HClO
	jDZIDqoKPBVaTA/EDeWs4bDUvbsYxCp9Fyb2fm82PnOuUgowtMfYavC9sRJ2NhYd1wSvuSlnNFo
	Jmt0/hjAkre1ysQHr3BzGE5rcgzVXwD9FUJb3L0Gahdm9994/XU6LZXddTCQ==
X-Received: by 2002:a05:6a00:4b01:b0:82f:49b5:cfc3 with SMTP id d2e1a72fcca58-82f8b551df5mr13447987b3a.18.1776737020637;
        Mon, 20 Apr 2026 19:03:40 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2401:4900:ae21:d323:b31b:43e0:4f1e:901c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8ec05391sm12529130b3a.56.2026.04.20.19.03.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Apr 2026 19:03:40 -0700 (PDT)
Date: Tue, 21 Apr 2026 07:23:41 +0530
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
CC: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: accel: mma8452: use pm_ptr() for dev_pm_ops
User-Agent: Thunderbird for Android
In-Reply-To: <ad9dd_-lLmazqD5g@ashevche-desk.local>
References: <20260414192045.3598010-1-sanjayembedded@gmail.com> <ad9dd_-lLmazqD5g@ashevche-desk.local>
Message-ID: <01DD8F0A-6CB9-4C98-91B9-0754E82BC588@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 15 April 2026 3:12:15=E2=80=AFpm IST, Andy Shevchenko <andriy=2Eshevche=
nko@intel=2Ecom> wrote:
>On Wed, Apr 15, 2026 at 12:50:45AM +0530, Sanjay Chitroda wrote:
>
>> Use pm_ptr() so the PM ops pointer is automatically set to
>> NULL when CONFIG_PM is disabled=2E This avoids unused-function warnings
>> and follows modern kernel power-management conventions=2E
>
>=2E=2E=2E
>
>>  static const struct dev_pm_ops mma8452_pm_ops =3D {
>>  	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_re=
sume)
>
>You also want to change this to DEFINE_RUNTIME_DEV_PM_OPS()=2E
>

Hi Andy,

Thank you for the review and feedback=2E
I will update changes in next version=2E

Thank,
Sanjay Chitroda
