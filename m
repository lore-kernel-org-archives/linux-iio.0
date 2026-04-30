Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E787442DFF4
	for <linux-iio@vger.kernel.org>; Thu, 30 Apr 2026 15:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777563854; cv=pass; b=b3qVGZIKQMcwsFAiXWcTeMupyvzSWJTH9dAzLtbv7Qs0J6mvnBIdp3WAB9QMOWN5P1LjkaeTegarQGqdwqMoaeL0AoabEeugAg08JFE9OCJKKFvxvkegsw4IqrcUVB8ersDj6XGRWpBexGnu110HRZGz52p9Ap8mNK3eqM/Rivk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777563854; c=relaxed/simple;
	bh=WbwMBa4zNxM7/h/CK8guB8LXTbPs8PibcOtmh0V9wi0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aFyUMNR2tvGROPrxp9ispptMpvVMLgb6KSd2q6Oyo7+cap8kb1UaQL/75vHcAvmzJz2oLzvfFSg7mA06gcN5Bcr75V+qdjZQBE5gP2ah5mIrQGEfJCUCckZS5VAF4jPZ3h/txXDnyFE9PvEpxLvJZDGBqKNuvfjfyfU+das0WbA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XbrnFhDg; arc=pass smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XbrnFhDg"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-7a4f9cf2b4eso9406997b3.3
        for <linux-iio@vger.kernel.org>; Thu, 30 Apr 2026 08:44:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777563849; cv=none;
        d=google.com; s=arc-20240605;
        b=Tc+e3LtGNnoRuPTY8ayk6s1rxn8IGHQyybg8ikVsNlQ9A8uT16FFDoA8x39nQtTcGH
         jGQBYJbQJGY2hg5kZ0o+0fHKoy2SilSxkYA6ncsqaoqnmVUvIFJl84nfPiYRXWByJwSU
         tCF4jopJssVg/iLK+wly7TL6Lus9Cg6Dj+h4I8PrfuLnO/JQfp6VwrhA+2gVECXQCyoo
         o5NBd+eGq5tWAH4ndWSqxIUSm/OF+BW+0HnFpW6E7TkvccBCZxWzy1HKb113s6g/F262
         tkdKZHkqqB0/hmtiUkQOCz5nWhUYanNsVb8CjLI27DqFhYw+SDkMci0XCoeQrRfr4C6X
         d+Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WbwMBa4zNxM7/h/CK8guB8LXTbPs8PibcOtmh0V9wi0=;
        fh=gTs6grJm7N2lk+vOEE35AL4V07Fbdaup9F6et/3RlwM=;
        b=ODYD2XxuNj9yPVVqvH9b3xh6++qxAy2Wq7b7dskIRjZo8h3RxC2h3Ge5VLoHKEKkB9
         hl2PNBuro42P7j5NoQqu+MHLKxKH7rVx8IPk4XdU/FOzzZmpxraEhTJTDG7vpWux176I
         mmC+BvGGFnhXG4fbditsNt55Lh4ERmXZ8zSThU+UlyCvedUsbTOGUD1/Qb6Z/82HjGMY
         KxQXoU+9hHpYiCGhYzs0vKWbsGtsCdpInA5a0atpMx/PafGXJq81Q1EK4N4AkTVac6nx
         sGHsQrezTbwrZfqZ2O0HBbf8Aodkbu9GSzAAZ/ktnrHgHBljKI53G5unymzGnh/M8GXV
         XpVQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777563849; x=1778168649; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WbwMBa4zNxM7/h/CK8guB8LXTbPs8PibcOtmh0V9wi0=;
        b=XbrnFhDgbKOKLjAEHzlZ3j1B2pEmaJRaEzeHa6glUYqpRdJhEqhULNrtCkYLJgYjV7
         uozoUW+uzmnDLVGeja0TQW8D1MtwhP5pGbFruml+94mkbwsIs2Ukxl2UAwYTIDq9DM7n
         qMZnyvLyUpNuhWj3uThIUZ09WGkHC2m09vTuEfIjLy+uaiGsDmEQ+xmhw3uJMKGhBn5q
         sTkGV6wLX0KCTBkeX1DBVz6sxwuQWMPtfqP7qO2FOvzPaTa/m5KXb3zu8Gq1XagfNAF6
         D2Rw4dr48J/haxtHvRmsxPFES8aZSXb6+lwagLdNtIIdEJsjJu9B4U1AXaTfauGxw2qs
         VslQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777563849; x=1778168649;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WbwMBa4zNxM7/h/CK8guB8LXTbPs8PibcOtmh0V9wi0=;
        b=aF2De5kmHtmhIu7EoPRWd+1RsWGfphPQTXjAqrtJsrKZz1iEwlGCb5bV81p/jWFo+Z
         hs7EHkXQrEmfaYG+Fs7FnBUnecaOKU84T6xS+IqnfXmnXoeK23mUq/0mt9ppfim9Gr4d
         vmqMJNHwRq71ZgozgotKaPPjrAQAFV2fu8OVd6BW8nS2BRCmumxphIgU2lsM+a86z0+y
         5O55lnbeR9FQu+BMz1jHke+9k7Sndo5T6gTm+WnktnVqRW/gk5Afmr30DYPdFocyZKV/
         mzxf+PO5CColpDI8wnXQRu/SR4zld+hC4zDihCiq76M15zq5/ErwSocsGa8s7enYLL3K
         H+TQ==
X-Forwarded-Encrypted: i=1; AFNElJ+jfE0iEd8UnyNYlXDiDAzWxkWXJxz8iNuUt9OMtIRKzPUsYv8lT8E8woTjern1o68PIppwIKpd5QM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvtfQVVEcBY22PSsC0tkO6qtvlbV8ThW8GgLvP8TXtaDqs38xC
	QSiWmv/3udven+Tg1PNPMvze/SH7bwuFj6Z5c/Y0YjXJIjjJG//13o3TE7+xUR961FRDe0vVYBR
	NTc5NVRzOo01cNtEg1twYzPEs1Nak1gc=
X-Gm-Gg: AeBDieuLhDDX6uvhixpYpbotEXbjJkzQa2MTqovw9MZjkR+3L6vi3HRjqcOk5x+PetA
	VjmEnxMIjtkjBwT9TfzpDc5RJlkm4FTQFKsRmJbFvZPXZgeAIky6EFXx5JAttWO7iPSoW5Q9Wes
	+tYYg7yjREoFYBD38SdhlCrV1SwQfgbFuTOIp3d1ImnG4CQCdoAo00KIO1t9CbHcNpZPP2+MFC9
	OhFR8ysaXcI1h6658tyCNklgTbsfMPkClZaQ4EpGhI0XF3aOoPVDcQGpHnweB9xkQtci1hNiCKa
	+NG3nMNA1jNIRIdLqpq3
X-Received: by 2002:a05:690c:16:b0:7b1:3579:2efd with SMTP id
 00721157ae682-7bd52a648d0mr37974217b3.39.1777563849372; Thu, 30 Apr 2026
 08:44:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260430124148.11572-1-m32285159@gmail.com> <afNR1Apx86FeAcKd@ashevche-desk.local>
In-Reply-To: <afNR1Apx86FeAcKd@ashevche-desk.local>
From: Maxwell Doose <m32285159@gmail.com>
Date: Thu, 30 Apr 2026 10:43:58 -0500
X-Gm-Features: AVHnY4IJFA3nL76z8UW1RNXVyOLJJcbcWfWcZ-vufVVnc7f9pC9GotGxdSCrB14
Message-ID: <CAKqfh0FrKeAL7+guUMmsvm3EkjFZjEUXQUMHk=x9adU+ZWv1eQ@mail.gmail.com>
Subject: Re: [PATCH v5] iio: magnetometer: rm3100: Modernize locking and
 refactor control flow
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: songqiang1304521@gmail.com, jic23@kernel.org, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, 
	"open list:PNI RM3100 IIO DRIVER" <linux-iio@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 30, 2026 at 7:58=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> I confirm that my Rb stays with or without this change.
> Maxwell, no need to resend for this.
>

Alright, sounds good.

Best regards,
Maxwell Doose





> --
> With Best Regards,
> Andy Shevchenko
>
>
