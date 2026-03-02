Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D427716132A
	for <linux-iio@vger.kernel.org>; Mon,  2 Mar 2026 04:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772426660; cv=pass; b=SA4/LrJoLeUFrZQCTHRpc1T1AcUNyU00VkX3eOm8ZmqAhXwKU+IJq95cw0kJe9E116m4tvP30IePuV6SqoRCFLC/XHVTpwPnXa0Ha9d0+A0SJ4gsMOWrax4OXl8Ns5btpRv1upXTlWCJAs1Vvo/UuxLGFMeFeg7cIFg//BWQNDU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772426660; c=relaxed/simple;
	bh=xbK/zKFovWtbSTAdL9DpSBVTJ+2mbgF0vEyViS2gaG4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=R6N3XQh4M0dhh3ireE+nCvqtVX+z6ZTnjoYtMIax/Oe6S+qNDHffmASV1TJtEVY/YHXD5ZbOPHKy4BPga4BGDjVQkpsNYxvrqizQ2eRv1eesoocn7+Qy2tFyG0FDDeltCzKwfW/wrRPM8JHj7qyRJCG6nFeomDS7eyxwBpGsNZc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=USOL7qwh; arc=pass smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="USOL7qwh"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-64ad019bbd4so3398184d50.0
        for <linux-iio@vger.kernel.org>; Sun, 01 Mar 2026 20:44:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772426657; cv=none;
        d=google.com; s=arc-20240605;
        b=A2DAG7wZhE/Gvo0UQadY3RwYvwBxnQMSSwO8jqQ9+VWuoZoJRRHCU/pUKapo7eUJUC
         5GZDaQtzzDoSq0Sj30PNIYIhfRHXD2y7m6YdXQxeDOljOdeV+4bCaODgbScHRzZjEant
         1R2MgjS38bBznja9Qw6L297D7YrvoP/wDsDRT+fTIuNSqqJ9hCukvcCMpfPe8K7QOq+X
         XN5oAHNoZv0xDEY5l02MdsWfFbDh1dVyVYOUoDoc72q/+dLABuoo84hcm9PJu1QmSIpL
         AMz75afLXLNJ1tXwagoxkEEgZGN7W8LMB2XW7FRdSye8k42uq4LF3ECQQAg5m6S0U7U8
         uohw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=xbK/zKFovWtbSTAdL9DpSBVTJ+2mbgF0vEyViS2gaG4=;
        fh=rgQyiRthZ1bhgIZhv1axlOyU0Ax+mS5iC4rjWubKv1g=;
        b=IvNMiSENA2mG7P9Ir/bGQxBjY5uBLQ8hEDqiTMawa0qly3H4MpGpVaJBwwBQtKQbVG
         J2/ctCEoezpk8lkCF5+6RpgfJeqVVtbghlCWmyc+I5saCWdDGD5bXUprxXsuYbr0QkiX
         ZLPWl0LaB5g/WZpeTrnq7vgBdlhjU0IefyVEjHdEJSqTtHkoxRmoLf535qLv4VCsBHDa
         gELaocponGUzFENf2GeH0yDoheeAhUi9104dsGclK8NsUZZ03Z0Vdnou6RXUA2tgLu/b
         xP/UMtQaS2M4m6OH+7K9rQfvAcxuIdvN0GxqQWQSja2D8xln3O4ph2D43uCRUYhtSUqd
         HZdg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772426657; x=1773031457; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xbK/zKFovWtbSTAdL9DpSBVTJ+2mbgF0vEyViS2gaG4=;
        b=USOL7qwh7ab1UAvFzp0Z4lY9XGkpUmrYdZyPCKeI9TnrmIU1oUU/tOO86fLJvbH+L3
         amGUe5J5XlX4WUMWhbepLWLTqPhsYFBtDGD0RffsRqQNH5xd/VEKu22cnIsszJ33y0RY
         T1/jEfHgECzw6s5MfSQ0Mkti5goDsgoRZABlSni2pCei/RIy3rnfjfwyB+IKRRGRbE9k
         V3I6XQPwX3PcQ0ACZixbqFDL6EMyovWwprKpx19aRGOkzZZ1ewzu/psUgUjIo1B4oUHq
         F8/3OWO6Qba2/9xqK2KDtlQp8buRjPS/XfKiNBfIe0zPb9SAEHiUyhBPEc29QtIluoCP
         Ov1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772426657; x=1773031457;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xbK/zKFovWtbSTAdL9DpSBVTJ+2mbgF0vEyViS2gaG4=;
        b=iJZsr1wN0OIrr1b0zjaBfNnbzd2O72B1ZhYQNQeqjQJgP9jyLeQ6ssteTFfjrex70e
         BKfMAQPVFmPhVL9vJ2/BwkvHMGcKnaN3nuJ5CtPF6c+4/CdXyiTGcLWSyMFS0YzzrGxc
         m9o3G4Lqajasf4NemY9Bsl27yhrkDIYjAmJSemtXcWlWa/we9HTWB3PrUp4fIBHF+3CU
         iIknlBT/yIJ4y4jI2It3Yh+obAp05bVWDiW9TuYUBKp3j3q2/vDddF6kxZGTQH/SCOl0
         rmXvDkm7RU9Xpoqy3YHdrz5LzZiwxV+YqTB+voFsHtiKKyG9URowdIiToLC3rytcXEJJ
         Gowg==
X-Gm-Message-State: AOJu0YyVEvQs7387OAcO1Mtns6YaTIShsoSP/VsnotaQIVBwhzAfiuXU
	DwdkqZSm74Ooa75pmhgWlBYR4MHw1wrSNqLeBfMNi/qjosccsPDZ6CDXRQOrDqA+JZyHl6oG+bp
	N4ALiU9cByIvLSr5VBC1sb1FailJ7cSwxpjpL
X-Gm-Gg: ATEYQzxFv/PP0xYQ6p/d/8wWxmUNB+Yz7wLrKrXWukopxit9FCVzyvWyRoYyoFy5AuA
	Z9Kms0k/u1UHl4FgQNQACnK9eLw7SHcMXZD5ZjS5YzdYV/rjuNOIoOXyjN+C1mg91BMB4KiDJHn
	yQ8GM13SpXjS69fAkBIhYI+bKkf6d5WKedRFSqUnOb+PF0AN2mAjHeHLJb8hcDJE22GMRjLLNiP
	8ddtHMqddAcIdGGyGUlBBkVLG3Yxfwnjs23gUZMC2TudDQiYfJJ0y324//0/CqRYWwGinnh6bWH
	/g78+HAk8sLR6Ltsjlo=
X-Received: by 2002:a05:690e:175c:b0:64a:db29:5e75 with SMTP id
 956f58d0204a3-64cc22c5365mr6880112d50.64.1772426657598; Sun, 01 Mar 2026
 20:44:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Chaitanya Sabnis <chaitanya.msabnis@gmail.com>
Date: Mon, 2 Mar 2026 10:15:33 +0530
X-Gm-Features: AaiRm50irh8OR9fecHs9MlJGIX995Gj8gVSeqnFEuohNPD_GmUnlujgxHizrZ-o
Message-ID: <CABjkosFLNXqDKi2MQELF+fmdrrqZvcyFZ1+xncrU1RHXrga5NA@mail.gmail.com>
Subject: GSoC 2026: Introduction - Chaitanya Sabnis
To: linux-iio@vger.kernel.org
Cc: marcelo.schmitt@analog.com, dragos.bogdan@analog.com
Content-Type: text/plain; charset="UTF-8"

Hi everyone,

My name is Chaitanya Sabnis, and I am a final-year Electronics and
Telecommunication student. I am writing to introduce myself to the
community as I plan to apply for the GSoC 2026 project: "Create a
Linux IIO driver for Analog Devices ADE9113."

My background is primarily in physical hardware, digital design, and
embedded systems. Recently, I designed an op-amp level-shifter circuit
for analog-to-digital interfacing, implemented I2C bit-banging from
scratch on a microcontroller, and designed a 16-bit I2S transmitter
protocol in Verilog. Because of this deep dive into hardware serial
protocols and signal scaling, I am very excited about the intersection
of physical sensors and the IIO subsystem.

I am currently configuring my Linux environment and ARM
cross-compilation toolchains. As I prepare my proposal, I look forward
to learning from this list and hopefully contributing to the IIO
driver ecosystem.

Best regards,
Chaitanya Sabnis
http://www.linkedin.com/in/chaitanya-sabnis5
