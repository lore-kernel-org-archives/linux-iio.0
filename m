Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6D13B637A
	for <linux-iio@vger.kernel.org>; Wed,  8 Jul 2026 10:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783506996; cv=pass; b=pPg+r30naIilgOQ/cYR4n1yR+GSPhMAXAq0o0yWfmMtg97OOIhcWW3wdIl22qDSyBLTRRObOfHtbQQCWyTBiCCx9o4Bn4tqspdAxLcCni0o3Bx/xEvEjiBZt0Mco9/qT7t0c/z+UGTm4s5d1lTgeoQYH2mLfW13xioti81y+KMU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783506996; c=relaxed/simple;
	bh=QzqSzBmO2/LNWpe9fGm4KLVQueTZtd5Ku7sSD56PRhc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XUv+jmZtBUpzKrxNGx/W/HhUh43RitutcFP0zX3+fyZ/r6los1H4VuUo45Kxt7eOFC4cc4c02xkFgcp98Z9t4GqGFvNQhmgIo19wOXSSVweddYCG1hd9qqgpcK6MeU1jH0C11kbGOMAWbavlwi+At5vzhV5czqz4mEzavBnTvTE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D0TRToUq; arc=pass smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D0TRToUq"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-384c94c9423so69515a91.2
        for <linux-iio@vger.kernel.org>; Wed, 08 Jul 2026 03:36:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783506985; cv=none;
        d=google.com; s=arc-20260327;
        b=K9uzELrpA9vUPs6o78+GXZtNEvU9keNgNynioOGQ275D2uRT6jDoXf3BUR/fRdsUo0
         zpb3xkdbyEGZ9SlPOgJh3LukX2H5nfFFrTI5kVZN0Ahrja7i5RhBtSTgJVmWHr8HK5Ap
         izsf9N45y0cQZ/+5Yop58ve7Kp+haVRpESmhvkdg8lDX/Oei4ca7rgnzmmiQ2rIWsuu/
         ubHkBo25BdDoMazrgElTXxvwMs4MY19WPcfShDzVNK5x3J5ejCFr5HFs40xOvvmS6ICC
         cq2MiXriOjw08WnvEVWwt8AsjTZUz5Bp4YkIPGa7+ZVl+lf/CfBUkjKcUSocwlYZVlxT
         sY7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QzqSzBmO2/LNWpe9fGm4KLVQueTZtd5Ku7sSD56PRhc=;
        fh=WjqL/O5qHLwUFRPFx2jRdJNvk+TQKe12KDp6Odeac+A=;
        b=s9UBR89OORdvoKjCRQ1UU4kaJOSthjvV2zSr7Dk9G59osw8lRsCPlEWp15ZN2YpQfF
         fe18xSQWV26W09zHpMuYFAj9fs5QwRfJ8rO+nMF6RjjOgIz3y8UZotoDgASqVlxsVxCM
         43r7n5o/cf3+SoHhcypi/C/kBQN/xV7Ei8BqSv0zW5/HXH/Yzhani6bHBblV+4K68n4L
         Q0abkkC9t30W4InJMOn+3CsC5MhnLWoDBkDfP+YwAepy2+tQ9lDIpxWDX5Mxiybvbkhn
         sHZAoEgX8yXQM5ynEumbJnjAm3KluRYNCvLRf7u3ze310VfyMQdbqY8ezZ/pakO2xaGK
         UNwQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783506985; x=1784111785; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QzqSzBmO2/LNWpe9fGm4KLVQueTZtd5Ku7sSD56PRhc=;
        b=D0TRToUqYN3Rdph001VmDw3gvRgj4X6J3yFtQ2Oldbtl3B7Y/MtUitwTij3J3KAEzu
         Pu5nb4rvkARj9WfzxX38LoWFQd/1rhiXARKq9+hIQw8kraeuSljD2QLKJ7sfzFDrOQbv
         bH1ZVkZRIqj1Ql7A7wGyUFVVXCDZ4dLAr8RLW2T1UCirRY/G3zY5KqM3d9xhYJXmoeon
         Nd44xV55fO7l/kdu7Edq3EGoaq/lcH6VOe4IRyF0y7ujHpWErTwTB+oejnQZiAmiMjn7
         Cg8G/luw0IaJg1EFDC2EYuFTo/NNd2CT7nbVkiCncvBPB/j+VhJUz5V7OBouMjLaaJ1O
         TuYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783506985; x=1784111785;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QzqSzBmO2/LNWpe9fGm4KLVQueTZtd5Ku7sSD56PRhc=;
        b=fzQkYNXDiiJ0JKf8PFokq3h1jmEzxng8oIOZdOZj9dYiiHW8n7txPrJqUa/sNE5+gv
         XdeWCopalEeZAchOMRwlYcZp+o+cc+f8FqITA35RFw1MdQIG2peKCazpBp+Muc7K085Q
         OHNg69OaZWMqru+heUsqwFlwlfPA8Tj+xSkcd0+V/moEYY+12mHCZfA3quDMFVWzOQJz
         oUo7fOCxY7D8zSUcEUty/2fvj7CLXRo+27Ts3spA7OwLjZVqj408LckWqZmw/dUdEGi/
         R8krH4Rw55VdbNybIdGW/41l8VzPRTWaeAnPQ5d0MlXq/0O0d2JuIShxZ+xvFdUCkUIA
         TlmQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr++Mum8qEGdiQkx7HSk++izG1y+yc8rrzbmwMR4MLoQoLXJmSC/bKnnwUSHeKRZK7l9q/17MWg0fQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSAAhobMrvK6qUCg8AnbH/Vt376hXE0+Hk/abNVIRcJ1BxgZqX
	w1RswMcKZBETisLfHwNRirt0jir7MPUwKPGqn+aoDflCODMXA27T6ZkpySEH0YC173GnIBdokSe
	0ihPz3KSHGFuP9flEEJCMDGQO6rzXf/A=
X-Gm-Gg: AfdE7cm/sL9TSIaXKvLjMRiCgcVWn9aY4aFhkWuyqUz+pMud0C2YVHAryBVWvkdqVyB
	OwXty7fT101S0IvFu31Ekude/gMjfn+EO2qv1/vTNTeDmYeiW3NWWtiS18kNoNKGolnZAB0j2J4
	SWb1oVhGl8bmUU8vIRrVlqlBnhLjOmV6DynpVFyzTVb23sGihuA9rpz1lCd8RFAzwZjlz9Qs4Iv
	m2azNnat0mbLMTmwX9KLNFg/MxGzFUPj9uJkH0m4CeULX6IZK/bdCpH4uU98zThK3aUGjXNG5/R
	83kYwbE1RXPKznyp2ixD6MR6vu8JOYdyGm8oCUS3DaafnoX3OOc0qa0hxkS2Xqc62SVpnQLIfOb
	3voVgJxXpXMRZ
X-Received: by 2002:a17:90b:3fcb:b0:37f:fc3a:382d with SMTP id
 98e67ed59e1d1-38941fb2d0amr1770186a91.6.1783506985239; Wed, 08 Jul 2026
 03:36:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260707151542.91997-1-muchamadcoirulanwar@gmail.com>
In-Reply-To: <20260707151542.91997-1-muchamadcoirulanwar@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 8 Jul 2026 12:36:12 +0200
X-Gm-Features: AVVi8CejjCB0cQnGD60nSceTy3aexNzKn6liFV-neeZ4M32IR5vUutS1Lqo1P0k
Message-ID: <CANiq72kQ0=MqAhrSSk3m5RNVrO+4Cv18xv1noTE1Y8TsPeRhDA@mail.gmail.com>
Subject: Re: [RFC PATCH v4 0/3] iio: position: add Rust driver for ams AS5600
To: Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, 
	andi.shyti@kernel.org, wsa+renesas@sang-engineering.com, ojeda@kernel.org, 
	dakr@kernel.org, igor.korotin@linux.dev, branstj@gmail.com, 
	rust-for-linux <rust-for-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 7, 2026 at 5:17=E2=80=AFPM Muchamad Coirul Anwar
<muchamadcoirulanwar@gmail.com> wrote:
>
> This is v4 of the Rust driver for the ams AS5600 12-bit magnetic rotary
> position sensor. v3 hardened the IIO abstraction layer and introduced
> kernel synchronisation primitives. This revision simplifies the driver
> substantially based on review feedback, removes components that were
> over-engineered for a single-bus 12-bit sensor, and validates the result
> with comprehensive hardware testing.

Please Cc rust-for-linux as well for patch series that contain Rust -- than=
ks!

Cheers,
Miguel
