Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28518481A9F
	for <linux-iio@vger.kernel.org>; Wed,  6 May 2026 15:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778081313; cv=none; b=jdIm39JSwfb7b+7X+DKyAbyjPzR4DMHc7SJ94Wxqm91ZJKWVoy6rdVhIvUJe43wiTdKL+otyoF6AqnZJf6ZFCUNwbdx1zdJV+rhsT3StfXIx9dOothizXw6xCZC+th9URmonOHOyxpNfnj91L4P0jjo/noY5aW8jqgRwrsHubaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778081313; c=relaxed/simple;
	bh=UPaTtxdqMhOsrrtkqWXAxghQy1n/T4IaWr4oZMFZp9o=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=MV/qiKUGQ7a/oEt7nGoko3zJ4wqd5hZ8pm/+jXLQcGOv2OZakoyEq8qa6VzcDzV/bHC1CT/+MyfjSqUWy+nY330v36MG+5nOOe6wl2x5eVb5pO/pmx7doL77iFdLiX9R5OPeYnT7pvHOU9ClDxwn/sabhtsJjZ7aW1RFtAEYv44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hY7zE/yQ; arc=none smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hY7zE/yQ"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-65c7a459105so1276441d50.0
        for <linux-iio@vger.kernel.org>; Wed, 06 May 2026 08:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778081311; x=1778686111; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XlIY9hS+9MIqs+znoNL5DDbyhnJt9Fsh2m2OkjwSrFw=;
        b=hY7zE/yQ7lXAVbKg3GCgEB2Cof+H5T/NUK///8axcoQ1Sm/JNEInkRDBPl14aJqbmA
         QTPjHuhJLXZMRSUh4cb3fqB3makCmXskRaiWwvz0A6B+YyQbDkupzNm13Ik4+OpPfQpQ
         wL+h5eiJwq9yUp5SgWLOS656Tgpo5QfUh5Aqdklv9dCPSJizo/1tspbsb+xKlK10mUQN
         o9YIAiGVbMXiL5SFU81/kcNw3Em88AGx4BTM1ltRtWQJN1p+g6V4hplyReeuTYMHm4Cx
         1NNgoeefZb6pyITBIOQDn32QvxhOwPhCwTwM9EyM4O3U7W3Y64rkewQWk61NUqF8ySmf
         0x5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778081311; x=1778686111;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XlIY9hS+9MIqs+znoNL5DDbyhnJt9Fsh2m2OkjwSrFw=;
        b=XikUKN31Sq77M4d/p+/x175yi63nBk8YQ0H5XUj8V5Et+TJmDtRZms+GTMI6PPq5Cl
         +SMol/S9OLzeQ/1JWxqdY0pLNz6ZHlKnMc1aWeA0VqsX2dPlBMQd2DuX7UK0kik3iRVg
         3Y2NH3sZnjsokSqz7vAF3l7/MPDCId6OO2VX03u6aiMLHvdcu+FMFGHH+ZFMdCkVcgNP
         dduvXgdLADcY3oSxuAdydUHL6qIthHsHW3/tcD7hdNh6LLWUtPM1TyLurC3t4RK/KkpM
         D+PQGCTevcJ4gUT2XNfIEjPowe45LtdmQ8MJ/GC9R+U9VLE4bcOTKqKEqHwJgTIXyeOR
         dq1Q==
X-Forwarded-Encrypted: i=1; AFNElJ/dalC+OeL5t6w9rRP5xwNpYavrGo67WxTmJuigh9FwMeNkQPZtW6rXmFUzHBljjJhh7+AhrRWwQmU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLhrySinHqgIyDFyzEZ632SFVanqyLyK5A1a1FYxxZnQK/d6U8
	zXNu/wEJZGleaZNZh40GkNpjXE4EvBv8ZPxqAsKYnGRPU7Yo7NSXS6QP
X-Gm-Gg: AeBDieud2RRgpSlLcSL44L0yaZqXPLtkqx/vBGae/vbkPxwWY9L59SegiCJcunL0D8b
	l0MohSDActioGdOUwyzdiitiEbRXbzVmRCegLgtuRKRi69orAezArHqD3idPWE+dMhhe5WKLSvY
	9UD3Fg84VHiN/LTyS+NTDpbrPkZFMpNVsE/cvaUvr+uL7A/QPyr2/V7gxFQCRAMecy8ijdBg508
	ceN2R63qnl9h1/M3b+3ecuNhtMlBQ2AN8gcIYLXERE1GrHSuBV0BKOtRGRhemzkgTsbFHbbUfjv
	1ODUrokVgHHbxeEgx1W7WtIu6l2DfVTQipN0FhqbZh4SDKOT0KCTBriizj+gJDXlSozM+DWYLP8
	ALWOounDt+wg3wd5QmNf552ZspPxLVtSByn1W68+TiyDDd5fUg0dm3fGgQEAQnplX7B5mFz97Nw
	XyoX3zVLFDYlFYE5XQfmTn82h4ZT9jNfWzpIp3VjBsEA4BO2N3
X-Received: by 2002:a05:690e:1402:b0:654:6450:19f7 with SMTP id 956f58d0204a3-65c7a125b95mr3398932d50.0.1778081311142;
        Wed, 06 May 2026 08:28:31 -0700 (PDT)
Received: from localhost ([208.185.137.148])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65c7af99c72sm1206764d50.11.2026.05.06.08.28.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 May 2026 08:28:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 06 May 2026 10:28:29 -0500
Message-Id: <DIBP7X7GR2EW.15FM732PJ1WOX@gmail.com>
Subject: Re: [PATCH v5] iio: magnetometer: rm3100: Modernize locking and
 refactor control flow
From: "Maxwell Doose" <m32285159@gmail.com>
To: "Jonathan Cameron" <jic23@kernel.org>, "Maxwell Doose"
 <m32285159@gmail.com>
Cc: "Andy Shevchenko" <andriy.shevchenko@intel.com>,
 <songqiang1304521@gmail.com>, "David Lechner" <dlechner@baylibre.com>,
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy Shevchenko"
 <andy@kernel.org>, "open list:PNI RM3100 IIO DRIVER"
 <linux-iio@vger.kernel.org>, "open list" <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260430124148.11572-1-m32285159@gmail.com>
 <afNR1Apx86FeAcKd@ashevche-desk.local>
 <CAKqfh0FrKeAL7+guUMmsvm3EkjFZjEUXQUMHk=x9adU+ZWv1eQ@mail.gmail.com>
 <20260505134538.73b5fec5@jic23-huawei>
 <CAKqfh0FNGsudG4B_VOv0nVa8qjZe03tzBEFkeebr-VY84syh6g@mail.gmail.com>
 <20260506154347.19e7d68f@jic23-huawei>
In-Reply-To: <20260506154347.19e7d68f@jic23-huawei>

On Wed May 6, 2026 at 9:43 AM CDT, Jonathan Cameron wrote:
> On Tue, 5 May 2026 12:05:11 -0500
> Maxwell Doose <m32285159@gmail.com> wrote:
>
>> On Tue, May 5, 2026 at 7:45=E2=80=AFAM Jonathan Cameron <jic23@kernel.or=
g> wrote:
>> >
>> > Applied to the testing branch of iio.git with that tweak.
>> >
>> > Thanks,
>> >
>> > Jonathan
>> > =20
>>=20
>> Hey Jonathan, I just noticed that I made a mistake in the commit
>> message, it says "Add new helper-wrapper function
>> rm3100_guarded_regmap_bulk_read()..." when it really should be "Add
>> new helper-wrapper function rm3100_regmap_bulk_read_locked()..." I'm
>> unfortunately not in a position to fix it myself since I'm away, but I
>> just wanted to point it out so it could be fixed.
> fixed up.
>>=20
>> best regards,
>> max

Gosh, I'm so sorry to keep bothering you, but I noticed a stray change
here:

@@ -7,7 +7,7 @@
  * User Manual available at
  * <https://www.pnicorp.com/download/rm3100-user-manual/>
  *
- * TODO: event generation, pm.
+ * TODO: event generation, pm.da
  */

wishing vs code would quit messing with me,
max
