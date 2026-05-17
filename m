Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3527A2E92B3
	for <linux-iio@vger.kernel.org>; Sun, 17 May 2026 07:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779002094; cv=none; b=jVxj5UIuBSXYnbufvfE8Ln5dmP4EINp05DYpXGwlM2PdkKiZ4GcAnW4fDkp7LFM41VJOCsc5sJm9iKLGLC6mbxgyFQ5qB+XNtqCzSuE1zvnmsW5O8AbCvRDPIVg8r5XxleuBDkxcJeb403VGnBjTsr1B4eQ4u/g5pCZH+i0uoTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779002094; c=relaxed/simple;
	bh=C5qrnk4Px0wKxbXP4sbzY4z34/g99Sb7h7icaX534vo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r53NwL9ppN9IfitHYXzsVMbmYq1HMXifwecH8dKhguiChEi6Vgwxeh7FLkCOYPB75j09pPNgtSIIYTA/PNUSTCdKjgYWmvqtFhUU2OhSrpaQJ7xfgAVy0T/5RXbuaxbPfSqfTjrHgdS1GM00B+esFjTHNC4MS464rBAPUM45rBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SO5WeQgm; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SO5WeQgm"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4891cd5927dso1651725e9.0
        for <linux-iio@vger.kernel.org>; Sun, 17 May 2026 00:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779002091; x=1779606891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J7+d33LTVY4ueQPeXmqnQ0x+waqN6RxnFKa13re1Dn8=;
        b=SO5WeQgm3w8fZ8X7eU/Flm6INE1JdQVMiVPM8mBOFGcUTV4doibrAI5pTalk4PZMNH
         1KrqSQTvLqer7oOMGmmpoHvbHKbJuJqi3x4ICn+8dBWYERJf9J4CveEhcNivEPFVPkCy
         QIjYLT9bSLrAbBEHROcN2+khlOtbfBNMUezNl+ZOnN7IgC5mF4bP6DOQftks4krjxs+H
         vpiKHQ4FK22TXFJ0xmiu6AimPs0Wk7mWoKJCT3Og3D97LLyz17dyeQbjPtPkT7aY/Q83
         UcJu6qjvN1hCy16tNxXDgsbyVtqY2yCgJd02yWNbpQo2w4HgipuKgla6WSjvAldQKkrg
         bXkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779002091; x=1779606891;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=J7+d33LTVY4ueQPeXmqnQ0x+waqN6RxnFKa13re1Dn8=;
        b=XDkXxm+iBOCD8Ava3xUEbThO4CTd4vBXWOyhIt5vtcyjNe+ZKicoC/akef4t2y3Wp8
         FMBdCFrpVCqXq4SmV3mKbD+9N+DOsVgpyMhWrqInmdmLn0ogG3oh+EPG2VAZ/7VXVrkP
         T6fLTPCWBnZcSZQ+Jlh8k5IHuS4+WLA0pesazm9sghsPglwbyiHDgtujB57dNZzBj3U5
         1xOFVayQM+9WlMgwM1VDI57rVsHGd1nbJbnXpnoixSYdAQkd+FcQi9nzD0mXMjKduBtI
         NT36f6xpAcfJIdXIunA8htH4g2OwBovZ8aAVi4XenUTsp+GsBAy2Jkn8bf+DaGaxj+4r
         YQQw==
X-Forwarded-Encrypted: i=1; AFNElJ+OL6vU2/pS9e07rxiyk+bFA3xCFxxkAi30C4esUojQ7gFNgHqNLH2LYkoHk+6GGVXcPAgyXKvCmfk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw03PajXH65e21vLKPwZQVVGHgyWF0xup8NrlM6JPpuNEfhA+dk
	Tab9O4Wne6o0vadpKGfpQUJgff5Q1GZi6o+AWrODgJuwxBxGV0xnCx/M
X-Gm-Gg: Acq92OG4Nj7tNVTfv1xngHesYO33DpVw+Ftck/IlIH3CPDznmx33A9nQCXPgmf8gcuX
	+R09cMhC/ZdPzdjh6FnPFTlJlfQKOwTF0eFr4GPqektUbMrVGcMNj8jNkR8OSic+lQmoyGh6WGH
	xedo+t23TeRQ9Y4a8hepU8b25rRJyDYB9xGNftcj7cnD4pSAKXjADH7oTCxCJoxi41aoSXJCCPk
	65mdUKEnOSGR8yOjUajG1XR44sS/7NsE4/NlFbyOvs48d4usBnLr0k1kMcwrWBLMzNbly/hcAKD
	b5FBdJ63U5OdbQQyoPTRFKF3hBwXXRTqa4Vxv0BqPINPKaHanJtg9uXLBC870A2esDNQTOPH6UO
	TiEZjp5RX1ivTfFgHErJSccQtwm6+yGuR2rkP4G5+o1vByLWhoAG4AReFfg8WOONFlphJXC2u6L
	Ec+SOBoa9GGInC2jWxrr4VVsto6LrlugWOkh4uufpl7NV8
X-Received: by 2002:a05:600c:5489:b0:48a:5546:619e with SMTP id 5b1f17b1804b1-48fe61f5830mr79209985e9.4.1779002091368;
        Sun, 17 May 2026 00:14:51 -0700 (PDT)
Received: from localhost.localdomain ([82.215.118.79])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48febe66544sm53656145e9.23.2026.05.17.00.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 00:14:50 -0700 (PDT)
From: Stepan Ionichev <sozdayvek@gmail.com>
To: shofiqtest@gmail.com
Cc: jic23@kernel.org,
	lars@metafoo.de,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stepan Ionichev <sozdayvek@gmail.com>
Subject: Re: [PATCH v2] iio: accel: adxl372: Add timestamp to FIFO data
Date: Sun, 17 May 2026 12:14:35 +0500
Message-Id: <20260517071436.61-1-sozdayvek@gmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
In-Reply-To: <20260516211935.36773-1-shofiqtest@gmail.com>
References: <20260516211935.36773-1-shofiqtest@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, May 16, 2026, Md Shofiqul Islam wrote:
> +			iio_push_to_buffers_with_ts(indio_dev, &st->fifo_buf[i],
> +						    st->fifo_set_size * sizeof(__be16),
> +						    ts);

On top of David's note about the size argument, the bigger issue is
that iio_push_to_buffers_with_ts() writes the timestamp into the
buffer it was given, at offset (scan_bytes - sizeof(s64)) from the
passed pointer. For the 3-channel scan here scan_bytes is 16, so the
s64 lands at &fifo_buf[i + 4]. With fifo_set_size == 3 that overlaps
the next iteration's samples in the same array, so the following
push reads partially overwritten data.

iio_push_to_buffers_with_ts_unaligned() copies into an internal
aligned bounce buffer instead and does not touch the caller's data,
which fits this looped FIFO-drain pattern. Alternatively, the v1
shape with a small local scan struct and a memcpy per iteration
works too.

Stepan
