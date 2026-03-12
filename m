Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581733F7E70
	for <linux-iio@vger.kernel.org>; Thu, 12 Mar 2026 16:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773332874; cv=pass; b=nxaN645RxLQDSe7IQOG5/fA8HDkEmabS+aJO3qNU/HNapVO7Enf2px3sIGrRgwxBqEsG8ZkMEPacEA8ZzXxP54Ky0lbnxlFax5ZAanjr3pc4VOp7O3lmWQjfOGMEQU4y6pXDIHdH/gECuw2HfEaMTMc2PihR8EvmlZU/RVZ49e4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773332874; c=relaxed/simple;
	bh=EIVyTO8k3rmfyZ9Czq+VumiRmQTeSxy+ofCT+6WEPQQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cQb13LbBH8gAzqYpFThe8VQFoKL9v79iFfDKx4cJuu9jBEX5ONuef6HB9ZFEZJxUbn056Ica9ar6h3pE9eWAV2ORSm5H8yIw7xsgCC/FoaO4nD7pErjipME+MTaFfjwAih98dMsEeMLHxCmLMnnu4diRoce+ximNNh2utkhfQZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RhaCI1HS; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RhaCI1HS"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6615c766e60so2056504a12.3
        for <linux-iio@vger.kernel.org>; Thu, 12 Mar 2026 09:27:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773332865; cv=none;
        d=google.com; s=arc-20240605;
        b=Xl1aA4A+EI4sW0D50QlluSc1zekUpUMo/KyDiPy6feKJXY5pcvDpBnapUMh/sVprvY
         mf3IeZkwSl4EjFcMwVc/T1ZNU4aBOls7J6Ngtbi2Hkz7/NyFoidw2alpsKDgM7D5P5jJ
         +KMXC7Z/zT3Qf9Cyx5lKPyBsd5v2k/MpJ9/MJA0dulH3DLPEdiH2WBPLwwdXlO9DhKGk
         LOTh/4+VyjGhFiXAHV91oNfT9K9pL3EekUVkYewSBCSrofJEFeuiecAwwlKKTSswOhdH
         dtmT8oUkysqDpGRtts9mXaEteGXexw4dwcUOl84xTAreYT++yjp/q+4HJxp0t0/PfddT
         S5bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EIVyTO8k3rmfyZ9Czq+VumiRmQTeSxy+ofCT+6WEPQQ=;
        fh=+0qHVCx9ZvBfmNUhmO5BDVxw+8P+vDuzg0cjJkBRnO8=;
        b=MihnubtdPCNkZ8XUQwz7WmlBynHnBLgyb5qzJX7lh6sfHZ7Qml5+T3tp6AHDK2ootD
         wrO1Woj8DpPShIrQhS9fC1VPXPlgMe7wqdxRwCEjnvlPWQR1Oh2WZmoPJuvQxZMjhMLG
         ymA1uDgJ0pEHc7+KocgAzBuwjEdgxpd1S7KUMwHoSY1O41X3b0W1gvydA39S6YknuTsy
         Pjk8ujgx3Snnr/twOiBbXilNYQp5krSh4CcltqGfjxqcllJjgUufp1diQN50jtrrRJBO
         kKfB8nQtJ4U8cyrHxzAiobFMaSwXN6VWMdzbeZSa8aO0lVRvqLEArE3WV7xHOD+hcJJe
         0V2w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773332865; x=1773937665; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EIVyTO8k3rmfyZ9Czq+VumiRmQTeSxy+ofCT+6WEPQQ=;
        b=RhaCI1HSnb+QaGF+u8scG2j/ZswgVyzDR6APmre6AFEgdYxY6cN3ofPM+tmdLZoY6w
         /cmxHMyBZC+aA4eGpXLE64aByL5Zyf9fb8f8reHGcxpnkz4jRD1nZFkObnTEkmm1MmpG
         i27LTuhFy90ihAYHBvOEUhmxTZu4T0483OjvVsCJ4J4MdGkSCxVxQWLi68HuPbYAw4Mz
         7TKPZ0OoZnSdbY8VR8Xb740U043w8hhtGgylMs1oi/6Wq7vfkKweb7AnQp3DcgvsY0j0
         ySI5/XbYrheAd2DIqN5u+EKnt/3ISEPxaE7anDv3s24dR58Mc5h1D0stV8yIZFwn8NMD
         yv2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773332865; x=1773937665;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EIVyTO8k3rmfyZ9Czq+VumiRmQTeSxy+ofCT+6WEPQQ=;
        b=o/p2RLl3J70VmnnDs8+sMtROpm7s17hlPbYoJBUZ9zwGLQwQFOfSZuMFtdyjWUtvCT
         N7y0r+65Obt0JlEo2I24aZ5bSTfsEdeOxib2kCWheNC+Hi70ZmBiBVuijGE1fOun0VgQ
         SVT6A1pB+PDfvk+o0AQsjpb1xSSgK+tYv8U81KeTjes2hyMcSOcVRhmNjWj/aOoxxGKn
         o/a2vUVEcvK0xWO9PZp5+EV/snEOCsv4xtdRTBGkgnEQlps9tz2Kz8MFSw7aabDYIQLQ
         BwbwKYwVUXgoWvBN+ROt1jgCmSfT0aSNQbmYP7hQxwcwERNTX7mRsab3Mfwj7ImdSN0J
         37Ww==
X-Forwarded-Encrypted: i=1; AJvYcCVHvfGVVLgDM29o24vdQ95LhD2ZIss9iZRJ4WE4dZBna/zFQcp0dgRFyHEKZWhv5xvToTmeZISXIsE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbX6Gk6d9OZLmHtyH8NRTAucS9NAVbHWonWIyM8Stdnbu2wnoh
	X+yOE4X9FxvuOOYJufcDLb4q3adEjrv2BVlObBZpBv63smUhlQCgvzZei9opGMJR+TAtqP34ay1
	MJ6hFn3Dk2I+SJ2zGTflKunYM7AjBSiA=
X-Gm-Gg: ATEYQzzK5rkhLIQeVXEdosSmVgm6+o0836XMsTeuFsudWF6FPH93Dxhcfj5WaQxOX2x
	rUdJmH4r8MVojMAWq4I0Dj3lyTz83W6yletW75yR3Rliyz5/yS68wjTEZ/6W9cgt66WQhqNN7Rq
	Q17hmMjOH+9SCHnc5xTUthMkSqqyPUmYpKxW3GibV3PitoJrJ1Gd2R32LiDkccVUG+ubFrcCgtU
	ghs4rpTr7nXXAe7HrVCJW5agrXdYsdWJToBS283Z0TFOPe/cjogiS+mJjAI/ITnVQmoeCbeCCso
	qqKKpRXFxTI/xe0q79iSkSgT3pb9utF5Z9gqqzRk06iuZ0itHKmxwWINyNJt95IjZ8HvGQsFTBS
	IDL6XraEi3lWDhgW0KvA8ZDbBxWQ=
X-Received: by 2002:a05:6402:a283:20b0:660:e00f:3218 with SMTP id
 4fb4d7f45d1cf-663ba9b6612mr27282a12.14.1773332864924; Thu, 12 Mar 2026
 09:27:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260312081942.23858-1-rajveer.chaudhari.linux@gmail.com>
 <20260312081942.23858-2-rajveer.chaudhari.linux@gmail.com> <abLLap9bN3tTXfD6@ashevche-desk.local>
In-Reply-To: <abLLap9bN3tTXfD6@ashevche-desk.local>
From: Rajveer Chaudhari <rajveer.chaudhari.linux@gmail.com>
Date: Thu, 12 Mar 2026 21:57:33 +0530
X-Gm-Features: AaiRm51jjYHP-QCfOv1M3APFYNgePZOxSL8cPtpYqKkWg8NQtQrRrLfUmATXEnc
Message-ID: <CANS1UbjkAEhaLYWoDRFenBwrW91ttzo12cXS2CjtmW7Sz0pP3g@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] iio: accel: bmc150: convert to guard(mutex)
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, waqar.hameed@axis.com, linusw@kernel.org, 
	sakari.ailus@linux.intel.com, harshit.m.mogalapalli@oracle.com, 
	antoniu.miclaus@analog.com, andrew.ijano@gmail.com, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 12, 2026 at 7:49=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> I don't understand why you can't do that as prerequisite. At some point w=
e
> probably go through them to fix, but since the new header is added, it ma=
kes
> sense to put it to the proper order.

Hello Andy

Thanks for the review, as Waqar Hameed said earlier to not change
anything until they have
a consensus here.
Ref Link: https://lore.kernel.org/all/pndwlzk51j3.a.out@axis.com/

Do you want me to order the headers now in the new version?, I would
be happy to do that.

With Best Regards,
Rajveer Chaudhari
