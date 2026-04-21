Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77032F5A13
	for <linux-iio@vger.kernel.org>; Tue, 21 Apr 2026 06:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776752406; cv=pass; b=O7cBjFDXr3Kgelq547hpFJifs5XQG+u92I4xCIf45VptehOwjBk/romXobWFuxkaN+NdcTAw48+gFz6ChYI6QOAItyaZ95+cqP72obLgq3kT+PszfFZqoGvggMg8bu+Lx5PIQt1k7IvCuLYIvWMCYomU8r5bPbxLimmaNZa0oKI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776752406; c=relaxed/simple;
	bh=znG0Q3kkG9gKeqcDJ2u627KRfqUidgPTlgHQwhKc7nU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=co8NOXXR36IZazFuNuyQ8gBbyYE7ohyLYF/ShQeihLFO4Z7Zpjr9zAMGlfDpfb3r88tGp6z3hRNMcZo/3HOUcHNbinl/nzaeedb2Q50xAWzVJxpn0TLEBDTGfyOmQXbUNqUmIG4cPaByf4ye0lsYIdPskXeBOQswHnFRXfMCZ6Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GtYWGnVn; arc=pass smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GtYWGnVn"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-441209fb77eso45433f8f.1
        for <linux-iio@vger.kernel.org>; Mon, 20 Apr 2026 23:20:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776752403; cv=none;
        d=google.com; s=arc-20240605;
        b=kTtwjt1YpTg6KzOJu0ovk/PjjRCD9eh/cQsclPO6JCu460EDywPLj8UNkcEvlE8dPZ
         h028uKXaSqSw26GpkC0cuedJzcjT3xhoahkPgvVHeACtd5aHF8v/9qxJ+CmDh/ugB24C
         c4APnQOFkthsCa0xSnipy8JFrS+VwsDRQxKDFwxgCU747HVJcPDJw4GxDHK5VBCGWCav
         Ylg7XpS5yY28/Li5Z3xJHDVYA5U1V9zEVRvgfMy/PcEb/tA9Jqo488t4+iOiS298A9eu
         oudJEBndNbaA3S+a0l2j3Pg80DntYwIfOmHs9gqDx6JnX2bzWr9IHiz+W92LCjwKamDi
         EgHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=wY2qAEg3d0PjYhpflWr979l2kFE+IjR+D5G0pl2UZY0=;
        fh=keZv512z6J8BFCdSFF4fz2KgQArRATZlS9d74r6Mb/k=;
        b=AMlDV4goFFi49QhFlIP332eIyUL0tneWb9HDFZsHiTPrJROghnQiqg14+haAzFAC1W
         zE4b7hPyupEllgzW8vwJcVUnK0SxGos/YXeCJboN8Z+epvhODsuiv3wsuV4IZi1m4vfp
         XOgncQWujvKojQDf4lDKrea0hetgq/L1ikNe8jHMgHOJW23SefZ10iYe3MIyxnZUyDcT
         UjzasfvVX1pqp18wPn6EdWz0IxgdaQLPw+qsJR4yEDmKLd1QSlUx7KRfhSEej728PsU/
         Da8whI4pOx/+ljoYbgGJqy36H5vmxDCQ1i1yJWVSUB5KNR9VGumd79gURg02kiyay7hu
         mkPg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776752403; x=1777357203; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wY2qAEg3d0PjYhpflWr979l2kFE+IjR+D5G0pl2UZY0=;
        b=GtYWGnVnkBC/dsT41YlT7PdMCSHKarfZJ0hTMx9k5f4DwsyOxwUY8mQ1HwxMTVIDKZ
         sR/6AFtx9VCQkOnOc2afHrdoaoY9Z638HSULm2Wl2c2MVIctnbMRfiZYkLCHXEY4VKyq
         BnOYaplp+7ZqjXHA+EufkOrGE/8MCcgE8Fe8oFZJHfTWN+G2syhrZJULNO6vKY3vmWwF
         VA2RgBtUq03PdtDDCSrBpywiKULmjbXwTWMa3yIhTkUypoyf3dH2vPXa6rZxAJvjJAMF
         gHXyNaBDj26+g1EKjgVSB9alSwJYzQnPTdZZRalB37+w9h+G1XmXP4xj/91JRVZpwuoD
         zMWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776752403; x=1777357203;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wY2qAEg3d0PjYhpflWr979l2kFE+IjR+D5G0pl2UZY0=;
        b=boOqGaOcRCyk0DiXygHJJAb4eoZlNW1fxGp1fTqo75tzzUL/OQrqN+S9OZcd7/k424
         bQNPlDzLgrVEakKK8dSBtmQXXPrcM9eZ/1wuq+gy2cK4ELfJkv3TT+pZM8LceTPkzeOu
         fbU3rwsfR08jywXbDCJn0QIa1Gv6z4adpw/Klu8fXH0UluPswly0Qr6PlEdC2FM9p9wu
         mVCA2dgnkBAva+2liG45of2LkPo5+fTfB7jHufuc/dR5Uws6QkVg7tXvbCwrUk0+xdwh
         DM3ObzLqv3nnlVskdHhbXqRccpCW7mECeA31ZQfnhWa6TK0HPJFRJMcSExAh/WRi0Ld3
         N7tw==
X-Forwarded-Encrypted: i=1; AFNElJ949NInRZBzyrYj9CJbLZ/1yIt7PzneJ9sYJU6pNlAgU6V9QvznqC0VuBTf7zMPZffHxgX4/lLq73M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8ANvu7QBztmpoYM9tTdAem43SzeSdLS8QRt6b84lRA7by57TY
	25ZnxR6XD+4HkEW1Rn9GeKON3cEmMo1RsUU/8aB6BhYFrDf8pNJFp2ZFcyy+qTXykfkhW56RDB5
	RX4fX+HaugSeYrBU6wKvTjrJrzfldcAY=
X-Gm-Gg: AeBDieuuGiJGUY8SmYca7432ETXC+R5RhyEw1lddlvXPicUOKZmO65ovzpl6CiJT1TF
	d6DIQmVoNTrVKgNy5qzha6O6nmUxhpOOeguZtWD9JBUK4e5vBkIMwcs0fF+W467mrTL7GTHEzat
	UfCl1oMbXHSePcz4n6On3GlU6T7WVHc6cvpWXXWOrRxF9aQMUkUIEKKO7pkQmFARp1DOyWcQrRQ
	/zqs2swaSxe+qUDzV1FRbP8Y3kdmV1rqMXJ03WHTwBtuMnwplQe25RJeaUvtFIdycBm2bwkc4qN
	M4aZHju/jIzL1aUIy/HvEbFjdqGpuI1TYCTVUKepUceBs1UlGCAimQWVu6syallZa6rnfjZTp5V
	QvFepjYaolYQGoFYik+MpnmXkRNgv7knktDyAhBh13Qs5ydJHOGF7MTkJDOAddsyakLIBvI0Sys
	hYOF1kR79eHmpp1oFJZrLGqdzKsmU=
X-Received: by 2002:a05:6000:270b:b0:43d:70c1:70b9 with SMTP id
 ffacd0b85a97d-43fe40997f1mr17678278f8f.27.1776752403100; Mon, 20 Apr 2026
 23:20:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260420110804.1353-1-joshua.crofts1@gmail.com>
 <20260420110804.1353-5-joshua.crofts1@gmail.com> <aeZhzETQk6afaw6y@ashevche-desk.local>
In-Reply-To: <aeZhzETQk6afaw6y@ashevche-desk.local>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Tue, 21 Apr 2026 08:19:54 +0200
X-Gm-Features: AQROBzAXYe3qrPqkTIMd668CAWzNdUWe5yLydnh8SJG6oeplgBupWxc-AEUSnyI
Message-ID: <CALoEA-yYREkL43wuwCKCrCNoKAK1Q0anPe+bgt6a6rVz9je+Lw@mail.gmail.com>
Subject: Re: [PATCH 4/4] iio: magnetometer: ak8975: modernize polling loops
 with iopoll() macros
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 20 Apr 2026 at 19:26, Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
> ' != 0' is not needed, but perhaps okay in this case to explicitly hint that
> this is used as boolean conditional.

Yeah, that was my intention, I thought that (...val, val, ...) was a
bit confusing.

> Somebody broke the indentation...
>
> > +
>
> ...and added unneeded blank line.

I should probably just stick to one editor.

> Also, use multipliers from time.h, id est USEC_PER_MSEC.

Will do.

-- 
Kind regards

CJD
