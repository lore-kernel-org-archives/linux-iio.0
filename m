Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221B73D646D
	for <linux-iio@vger.kernel.org>; Tue,  5 May 2026 08:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777968493; cv=pass; b=mGsSssVU59P6TopT9tuNy4yxN604jZyOoJbvccpflFU27mzgVC2NGpF7I1KnSuuVU1XB5pSqaQSKa0SFyXMmStTWJbKgl+d1GJYCvZfJN1mKfm8/cRXJcyxUM3lqMsN2eB0afcDduyaULND5GSkZTx+fJpRCpBsB1ozIPeHL26w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777968493; c=relaxed/simple;
	bh=IPE09n40ZfdKS5FW9vB6iZDfw7XolyW1hD4ribwyvMU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UbaZmBLQQs33iuqAOMJ/Gc1c/xjrGhFYmjrnI8MiIE76ITXC4r8sRcr4NljAUBc5NqUQ+wOrik4iB0QDvrYNuKJakACYmGMdOyge0mnmXuKTTVgsC/VmIHjZaT1lFs6pDsLDeHAdQlvXSmQVHQstuiwB+nyI4G146Y2hw3Rr5n0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i9yKFV0J; arc=pass smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i9yKFV0J"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4838c15e3cbso39586625e9.3
        for <linux-iio@vger.kernel.org>; Tue, 05 May 2026 01:08:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777968490; cv=none;
        d=google.com; s=arc-20240605;
        b=e5yMQjQ7IOAIpspwKqSOD1NljiDUGACjhN1XF8OFFXI0LbtzuAWT4hwzHKUFx+wCnJ
         d8HVd0MQEGkuSHGL1eHyjpC9AOBj/UY+ogvZ0p5pbEl0RcnNbHQnqs3TrQWnCz5UK40G
         ZWQlt+z+GI7Cqfa6dru2E/x3NS4KQfa4RLixd7BbtRM9aUhQsbgWqeyiRDkeRbN+nRdG
         ZQeapV4rF7fMueCTxaLB1HiXaxhYrtgtLDjuaukzrp9zO5kI1Uc91BPtAtRN22hYIARz
         8G5aRe1hCP3reSMRx9sPg6oGsww7eslIJiQOkm/SfwSFk8/WzjMGe0+9YXkmdDi48Seh
         yBYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=qn4zDIpSqWLOFkRgqCDysZizxCQEqDJw7U8Agwn35gQ=;
        fh=+AWxVALe2yy1v01dPl0uG7XU5C2m9nbsYoks03BdTic=;
        b=QQO8M7hRCc7cQCPDjB6neLug+s503cTuJpj5KSeSC/gp9I9RqdDdhvl4Sx6p789wZY
         3ZqnBL1924smhFb7OxHXpHYZLp4SwMs7oWWj9L5olVy7lwX++KM3HrVwOXfcmEA81rMn
         gCk5TYdF3AnM/JmO1NHtOqV3WHVlctneD1HdS1rTsRXJXX24prlx9UP2wZJbuuiqCkUn
         aNJmxUKTqhpCtP0woYuk26QlnaMRgBUI7c1hmBHw2zKcns/U73tzX5yYK+45uwkB4x7c
         oeONxUVb6QOvvV0AWz1nHO6TUvwIy17DGqTnk3H2yeKYZxRaVIXJoL7pnn5l51rI1II6
         xh4Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777968490; x=1778573290; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qn4zDIpSqWLOFkRgqCDysZizxCQEqDJw7U8Agwn35gQ=;
        b=i9yKFV0J6m1qvzSbyXJyRq7+yUcof79AfI/Z8sjC/fGuBdYWpg+2ErN9H3tHSbxbe1
         k2EsELy9G4iU11fBjA/1DUkx7W2beDwm8YyY3xS0T/1XWzPH41twmV+XiEugcy7MV9h9
         RpZp04p0VhGnMerWQ/osuhsTUnnIEN16slGL8rWv2PDVR1/BXEaJ+MlXcyOOijBpYWlE
         fGmvu+OuxO4Z6+cQM+gH0T7hgXlrVKmiVj/5EeZRXKKD7oKw6iZadbwgcNamjvsTJ6GF
         7Hw5AWfc2Oq12RgEdRFFX+yFr3zuSwqt3l3Fg+XOWrtU1ub2D0t155QUrcZddveNaBTB
         fLWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777968490; x=1778573290;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qn4zDIpSqWLOFkRgqCDysZizxCQEqDJw7U8Agwn35gQ=;
        b=OIF8bd14FOUYBB9TgdRzJlE9DLywhdDgcHcBqh1p1h+j1hseSrXruiCOLVEHmUFJx7
         r7VtXkOefQC4xu6RxCMG0n7fa/krMJaCprLOYCg5DwqGhQJgRckozFiAo1vf/F7EiQOJ
         usty4ItjsSQirhGLVowsFySBCSUHcONYKd/vWNKPtL6WTWpV3uOUc6HhqFqrUiagPTAJ
         ekjmQ2feC8RWvtibKBozPsBudkoM1ZUOTq8xMgPDfWOhWpbpaBnyBDfxKUTyMxd39xyV
         lbI5eLmLTwhRAGllUIkw+LgsYAUkRDqNwkf1cydMyLaWkFyWvD00vAuVUI4zxBNrEI+H
         sPyw==
X-Forwarded-Encrypted: i=1; AFNElJ8nega9swirTNvi8rAyu4Twqkj+/g33l+lmx54wqLlGDA6fHDM/tH//fde0ReMCsnSyNmxWVzKmmDc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZwonpS1p2A3hiu7+67yS9N4e/i0sKGPPlihxbo9IxlhLiLUln
	m4yQ85qrgmSC3qnHiWgQ3dEmG8VJU8HvDcs4xITYfPupPU2N1uTS0M6wVs/wS2olH9KRtH5msDm
	k1Xfy+SvWFPIW97bExX9/PB0u/GOAef7oL+1q
X-Gm-Gg: AeBDiesa9v6Z9fYB3KDdPKX6NSOwsgzbUKGn6EBiQLk25nlQDVggD0wof3U1MC66jiQ
	9nb1rK7L/qVja6D2nOIwAfkWHQT7XLx1E5KoOxCqVvdmdeFONbc12EPYjrS70AcZdLLBpKcyWJR
	PON2DatOtZDQAmAO8CzVGMTnUcJkKvYkTcOugKWKSXs0f27XVT8Pyk6xj4pMSNeqK9f3IeM0Vnm
	RDbXAjg+LQ+z5lHcSi0qhATl7mkYUDSY1vAncvLrmNvwfJk96I0V/l5kXX6i8HWj3ZCzfhJpisP
	swdYQGD8OprjvFVPAFXcoPwJUc/Ms/K4TovloyJFKU0bFCHPQ/z6NmSpQNt3eEifLnc3Lj50rOg
	V5dJgZOCCOOBavyTpfZCbVf8W0mpgCLP2xDkzyqy7QpqMvzw13S4JTxBMLy+UyvI2R1VbPBfFb8
	0g+8hMFYYD1l9DxN5v
X-Received: by 2002:a05:600c:3e05:b0:489:1ff1:74df with SMTP id
 5b1f17b1804b1-48a9852fbcfmr218842955e9.1.1777968490459; Tue, 05 May 2026
 01:08:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260504-magnetometer-fixes-v4-0-a291c2a7c71a@gmail.com>
 <20260504-magnetometer-fixes-v4-6-a291c2a7c71a@gmail.com> <20260504160606.07f87f10@jic23-huawei>
 <afl404iaPbSsK5XF@ashevche-desk.local> <CALoEA-xkOVvGqwWdHMS3HbJSCrSbyBd4GQ2CkczkT9Tn-xO_bw@mail.gmail.com>
 <afmag-hFCs8u6jN7@ashevche-desk.local> <CALoEA-zs+Qf8QOD6zE32Es3iGOo12KsvtAKYcd3LTQmoBwLw0g@mail.gmail.com>
In-Reply-To: <CALoEA-zs+Qf8QOD6zE32Es3iGOo12KsvtAKYcd3LTQmoBwLw0g@mail.gmail.com>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Tue, 5 May 2026 10:07:57 +0200
X-Gm-Features: AVHnY4KKCsdhrc1fz5WE7i9QaHhvIe0iAe6CAu4Z0dZq5pd3WfCvgyUAtuC6QJs
Message-ID: <CALoEA-z6omi2JzqWrtrXKwGTx372pjcFZikutPVeVc2x5QthTA@mail.gmail.com>
Subject: Re: [PATCH v4 06/17] iio: magnetometer: ak8975: modernize polling
 loops with iopoll() macros
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 5 May 2026 at 09:26, Joshua Crofts <joshua.crofts1@gmail.com> wrote:
> > It's better to integrate it into the series either as a fix (should be first in
> > the series) or as just an improvement after readx_*() conversion patch.
>
> Better to do it as an improvement after readx_(), rebasing would be easier. I do
> agree with it being added as a separate patch though.

Before I forget, is it better to return the negative 'val' or -EINVAL?

-- 
Kind regards

CJD
