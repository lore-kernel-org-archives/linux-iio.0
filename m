Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F27481236
	for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 08:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778573438; cv=pass; b=ut2/PLupzJs5EKsUFvD927t3+JIWqht1VXL3EXAJvGEo74FpU15wHcFelJGXSY2Af/8c8dj4dOJKcIgJwI/boyD40cj47aocWpLtzn3ZAu0/ymiJPahRpX416CexOH56asfMetCP0feNVAlgW8pVA8cqkSyMa8HOAHfjjeMhu3I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778573438; c=relaxed/simple;
	bh=MszvAbBwqTX+k2iSHA4uvDzJvGHpDb2qzCRzurGw+NM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tGh8eJJke9pXgolhyMqqZ4gBl7brX9hl21q3RuA1BJdb8DURLdK+JRL2MLKbI8O6zXUxiH5jrTD5ShhuiaSp8njz2Q31F6LsaCuk6KqQDzLZA5YA/SYayFvReyRJ3YQtJiEEq0mJcVKZ9+huXM2/ambkVaZAfSOoZqPJHglDS9U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jeRf4XLK; arc=pass smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jeRf4XLK"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-43d73422431so3976571f8f.2
        for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 01:10:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778573435; cv=none;
        d=google.com; s=arc-20240605;
        b=ILNjaBpxRxg42YvNVyEvkMUU3Ajay0KS+eIU4KgnD6DoL8KyVH1UqCLWEHH1GV1I8l
         IyIWIC/1Y9avhIU6wAi8b2OF1m06G5PPhv0dXHBZG6RVazA7m0JX+0wJUFMIFwV4fnzX
         0g3uigv54tlD23LIGijYN0U+LJoe/SkoMbe6vTjdgIT5/eTnQQ9jEyyOEASPwBcPqjDj
         Ym9tK8jwZgyzsImjLVCmcgN1D9O1lmd+8MysIQ8Kqg91FeRGjAexSPkzPI89uJe6Qbkn
         AtuoWTi3XHpHXcN1w2HQ8pLg+vLj7GZMrVufITQ8wG/sKPCygkENctc3mA1NnU5GwSUF
         HUjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=IxmTZetwWXAIZATVRXYrpmvB1+EmW44U6XwNwEq+3G8=;
        fh=jhRbd+YuJJtH7/rGCg9APoLlHVvtgzgvN/f7WFMQqSQ=;
        b=dMr/uRpq/iD2EEED7iYUkRkkfQtbFFJjwN4miPFQ51HPeLi8eNhNDEnljQRsXux6C5
         PbKP3FNU0Y9YJH/2PpWXBvQ0Oj6IyEPNabVjCrxO0ChFuZ7g72oreW+LE9J2ogZGF5+d
         mtOAECtTYZKe15kshPedqYyqzWxrlR06G+FKsbHRejUXdAc3ghe1qvr0QBxEbpQsngjv
         n/himFAgh/0Ttn0Vw+2VOpKrB0joUgzF0WRX/8jGTudFcYQWGE/JAIag/Wx4R4n8Xol4
         6Fnjr3ZIhGNxHvQQHca98iaTl8ikIUaens2P43oqUAuU0Gn2O0ZxKZDVkRVU4UN9BjG/
         aTkg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778573435; x=1779178235; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IxmTZetwWXAIZATVRXYrpmvB1+EmW44U6XwNwEq+3G8=;
        b=jeRf4XLKq9p2b7Zcnu/W9f/yzJ414B3dfKRmNNxUfIHR78jKqFS6y3V6p5CSzexYzu
         KtbOoZcv5AR9hkRggJn+vmbXrxNDfr8mYQk4EkIxDEyyN05R8UANB05+vNsMxvCw5Ofb
         zILjQKBwqftAhZzjSZLhNVXlw234naGEpCkb5OTCyat5dqjxNTfczWv7TPCU0iubr5b8
         pUbim3GxyNkY+ep/vbQYWV12k2tr84CNw9WausHWrxOJp2uR91hW/LAb9P9KhRidUZVp
         cbgPC+es5dU55cj/nh9bNqcYHh6PsO1vG5Km4UJ7gYcN1ATPk4t1tUz08spnCibT04eN
         NuJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778573435; x=1779178235;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IxmTZetwWXAIZATVRXYrpmvB1+EmW44U6XwNwEq+3G8=;
        b=rPr/PaS+IP5wPFp0mdhd9lRBwjaHfRgeknfL2bTz5jbWTGoJZzQjomM+k1ONhJMAWM
         3hPGhueCqqlOa+oPRXcQLOCAVKBsV/6Fo1/+7M7fRji6uyplHvikFb+tvR9ZV2cOTOK9
         LFy+yKMdzKp1jv94m7lul9r7GWXEJ1wHchhALtfYKUUC/P8ZF/oVZNdSA4R3JotLhZle
         DzgoqxZknvgTzkpUtgyXEpwFrJ5Zymr+IzE4gyThfkonZKVwrWueEO2rb6IoHgOtsrI3
         zCSvB4gxKC3ecquywQpEZqzS0Xdp9bGo55pIvrwpWJlAko3ZMDfH0kej7exqoHKYMKPC
         8+pA==
X-Forwarded-Encrypted: i=1; AFNElJ8uIpmDGRiDhWWoWd5oULKHalxmAM6ttLfF9NbWnprqwz8m3HYQRhiTuWhZAI90C6dTGmop29ZJTQw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg33DU2zV1G/bbfQGrv+Xoge5hdqlLunLhiXKP5LjJSK1z31bl
	pKxKlVX/CEQ/VtqOHIjc0pe6OpzAlHLkV+gOFR8gmQP7/CXJQ6tJUq2FyShRB6r1geCQCNN2KYo
	ew4xZmVwML92V8sgJUs8aouF7wszhd0zFJd3ykMA=
X-Gm-Gg: Acq92OHgn/hOO+44FyV6wd1T/ZEvRoDjJHQffHnUIrrXAYtb8+17yf2BcfaYkflTWNc
	NHhLS1UTjvL9XV5mETcSIgnqR1kkiZg4WPE+X/iD3DwIe4flTUsgOSpYiC2/x3EwI6B8EJ8gF5R
	WRQSHYFcH70p0s+bYCB8jZZEIBVI0swiARUfxMN9/htUI5AYJ1Vkl23sFvDiX4FgHlPzadRJZ4v
	WP1fKWxdRaVZ285817FOmYW/wIpMGKlkD4tWn8z10VdkgyxK29TtntN+DBwBTd/qfmLbyxoMNsk
	b1b7gplASgnXgCDFiL10pv48EM8g3KmmrTz4D7jDTBjz/RAr4HfLQWQkMBOPxyTQzK0Pe5Zvfe0
	bAZcHmjwx7PHhM6J59QPLmWPsrJqAhT+FMgt/v5MsSCRLUOOi6VdbCjkwtqRtkqC7lqNwcjh5JV
	15UKS4ug==
X-Received: by 2002:a5d:5f42:0:b0:455:460a:33a5 with SMTP id
 ffacd0b85a97d-455460a3511mr23293118f8f.34.1778573435387; Tue, 12 May 2026
 01:10:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512073505.1310-1-joshua.crofts1@gmail.com>
 <agLeEitdYsi5O2E1@ashevche-desk.local> <CALoEA-wOAY9fYuZdZZHQFj=+xN=WB=Z30g_iKJUVQHHiHHXxuQ@mail.gmail.com>
 <agLfuwvEH3YTT2qV@ashevche-desk.local>
In-Reply-To: <agLfuwvEH3YTT2qV@ashevche-desk.local>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Tue, 12 May 2026 10:10:22 +0200
X-Gm-Features: AVHnY4Jvg2idfz9sgWXlml-ATpciqzG4ONCvAMbtls0uecmKY369GmhRfUEe6Q8
Message-ID: <CALoEA-z-C2tq=5wg_+JOpda-GCpY+mCBMHxishvhGbUFxp6f_w@mail.gmail.com>
Subject: Re: [PATCH] iio: mapping file for include-what-you-use tool
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 12 May 2026 at 10:07, Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
> > > Trailing whitespaces.
> >
> > Well, considering this is not intended to be an actual patch...
>
> Still better to follow the common style.

No exceptions :)

-- 
Kind regards

CJD
