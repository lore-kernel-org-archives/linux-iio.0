Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E0C32D7F8
	for <linux-iio@vger.kernel.org>; Fri,  8 May 2026 19:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778267809; cv=none; b=lLfah0jnkR6uql5xouar+HVSZgDeEfJUw4q13yUrWPj0AgUW8cuHHVh9fwxRMe8XNDECyXAn9FOo2jYhn2G0LprqXKU4+Bbw9twIoVTB9txwfrFNvRzrn4BXFlJ8lbBEbQInM7JfUHrLoVyO8sLyji1lWynV9DWKmPWsMfD1NPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778267809; c=relaxed/simple;
	bh=xbtWBW+nQPnx2Cwu0N+CjfnUqwEUHF3QpzPNihT3Fck=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=herivEAkFFD34xXpf0vnUh25iJ9CquKgyG/lcNB9d1fnRl2anT2yc+bsPFlJraWgOg0hm3+OiOo9DXyJH0NFJ3tVkPJy0KY3y8m4+FaYIfoAqVc4+sCdaqYDmKwcclJRSobDKkUyst0HnHq974V4XKO1eP60jelfvTUNWA50WrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QBglkLWY; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QBglkLWY"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-43d7dab87e1so264499f8f.3
        for <linux-iio@vger.kernel.org>; Fri, 08 May 2026 12:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778267806; x=1778872606; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xbtWBW+nQPnx2Cwu0N+CjfnUqwEUHF3QpzPNihT3Fck=;
        b=QBglkLWYyVARov93/PJjg4odO5l5QDfe3sJLQFsXT5/zUDTrV9bmsLI0nVCfpBDvfg
         Tg9t2GH5W4osfLkMjQWapP81y+gbrTr3Xw7UsWDyN+A8wxAIOLxZK6hKMcVIIpCsQlbV
         aUOHoBUDGQ407+A9or7gexBuiNbTBDEMAlrL6hYl3ebrC5qsRQTyIKdJu5o6jtflJ9KU
         Len+S/SjJabe+1dVaWLWkFg4qga5TPV3MmD/nKkux/O35ilj5l40mVMXiWLenS0HlLw1
         DOhE9zPMVNi2N4yNKzve8PtM7zUktv2QG1UKD/LFh0ylCXSkvcyPa9KOUUllBBIeFAHH
         ztXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778267806; x=1778872606;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xbtWBW+nQPnx2Cwu0N+CjfnUqwEUHF3QpzPNihT3Fck=;
        b=Ji8vOWxOXSHDTK9QMwClp4sqhc9ZIe4aG3HXvmcPa7wr0WtnVQSUkKFxaNcPh+cenN
         0zymfwXzB/2ub1bNZyLEAqwRJdZqdnRjzVPi3SGJclP5gd3FLeXQldmytmK3stxZfdKd
         SK7g66LXO9eRfG72U5BivXrxy2McvaWoX6jGYNzQfumo9nLBvTBMftSl+4dcso7ss4tz
         cHUNRESc+YYhye8LOCgUCxtjAnUL+aZ95eDiR0iXv6DrCq2V65k1r/iAW0fZMhFsbZ+P
         q2D38t0I/otCu4ys3mhqrUv9QDyfis894KnXlXW9OHi7eVxPY9lYsIZK+AWdn49hSNJV
         mClA==
X-Forwarded-Encrypted: i=1; AFNElJ9ApuE86+2dbDpe0+duvtp2YOzqyqdEimcViRJekVVXliug6djxUKGdPOUStGX/IQOXmCI5YcLekck=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAtl6z+4nMOQ7y+O/HJfgIXlQJpjDOtMVn7QPuOQbjMJFrFl16
	SW+Qph5FUxdLcHONPF7ccaVgrBheyE8idwYTs8RS56EWQNg6IaPkgo+/
X-Gm-Gg: AeBDievx2G9w2f7KctX2nbIf3vFa72KPVFH9zGhNS31vOa9F5kvRzYVFJm3aLGkHIpP
	ICJKZaLuTF9WCYW7n8qWSeokT0dRQBTMugZSsiLVl0PIoS4nhhtfI74Zxf9ZHJJ0Js3UMMvqYwU
	2VjREvpIyiTV1Rgq3bKNHc2Th4QLmw4zj1PVF+a8jfCVgGV99KRmk3rXpk19Y2NY+cmMWr4YWoK
	Lk50ThWN3bUCTjQoho+zOZEahaiH8jVHsbJlW2wZk/2cdHbLp7VbPLugSW+bz8RqxMmrshbRpGx
	cMKlGphiTQSQRzuOUvKOh1Rxr6B/LE2RK0VolBp/nU5QYcEDWbD56uQwMe8ma6S0Uan+zCYpaMr
	Hwu5wKAnBh4iRttHdNE0v0mM6B/+mvdX++kUpLjEDPAl+1cxsXdp+zjaOP1dUzdWVNhGS1K/s7o
	EkPrS3Aasc5W3hwV+ob1U7HjRMxCqFndcLfGueFHeY27U=
X-Received: by 2002:a05:600c:524a:b0:489:6c28:dbb4 with SMTP id 5b1f17b1804b1-48e5329e323mr96668075e9.5.1778267806320;
        Fri, 08 May 2026 12:16:46 -0700 (PDT)
Received: from localhost.localdomain ([94.158.58.43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e6dd3ff54sm18446945e9.15.2026.05.08.12.16.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 12:16:45 -0700 (PDT)
From: Stepan Ionichev <sozdayvek@gmail.com>
To: m32285159@gmail.com
Cc: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: chemical: scd30: reject (response=NULL, size>0) in scd30_i2c_command()
Date: Fri,  8 May 2026 23:16:12 +0500
Message-Id: <20260508181612.11176-1-sozdayvek@gmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
In-Reply-To: <DIDF7CF01QK0.38MS3JFMU6RPL@gmail.com>
References: <DIDF7CF01QK0.38MS3JFMU6RPL@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 08 May 2026, Maxwell Doose wrote:
> I guess we're still handling the cases where both response/rsp and
> size are zero here below?
>
> Should add a comment showing that this handles this case but that's
> just my personal nit. Not worth forcing a v3 so
>
> Acked-by: Maxwell Doose <m32285159@gmail.com>

Thanks for the ack and the review!

You're right -- the (NULL, 0) write-command path is still handled
correctly by the existing rsp-NULL branch below; the new check only
rejects the genuinely buggy (NULL, size>0) combination. Happy to add
a short comment making that intent explicit if Jonathan would prefer
a v3, otherwise I'll keep it noted for a future cleanup.

Stepan
