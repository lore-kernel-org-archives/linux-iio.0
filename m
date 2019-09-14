Return-Path: <SRS0=BP1q=XJ=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17E26C4CEC9
	for <linux-iio@archiver.kernel.org>; Sat, 14 Sep 2019 09:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E03692067D
	for <linux-iio@archiver.kernel.org>; Sat, 14 Sep 2019 09:56:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hVvsT23a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727975AbfINJ4I (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 14 Sep 2019 05:56:08 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:42585 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727916AbfINJ4I (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 14 Sep 2019 05:56:08 -0400
Received: by mail-qk1-f195.google.com with SMTP id f16so4580173qkl.9;
        Sat, 14 Sep 2019 02:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=U9fQqRnkdiAY33DAJ/B1Trb6FOzukkEyKoNSScykVUg=;
        b=hVvsT23aryXyHirzGdMo7DNhcKAP95j00sRgZInUN0c70xzev/6nThadsP30kSOAa2
         s08yfK2MFhVQiK3wsHKjgHUySyC+cFZH1qJyhJIgLtsBWWPNSHcC3FZuYztyeAKWg0Zt
         O3oAZ1KoN8bn9C/mF/wpzrGGDyzeF5KXWNwfwRIlbdDC673vHPUBez3iwMnLP5PQuQWp
         v1tY6k/vauNfF/ZGWbaKYbQa2jm4rORuwqjR3yGYY69+81XZ/5IdrrkkJuEzTHAWU0k1
         2Zv9uv1pKvE4tnetj79vJ2sWWGlhb5dmqyfLc6zkz81I0hD+05pki/A0WH8Fm+eq2R10
         684Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=U9fQqRnkdiAY33DAJ/B1Trb6FOzukkEyKoNSScykVUg=;
        b=TlTP49KogChwQWmt9tgNyJNzTlQDBeZlWW+bBEe60BG8nWHWrw0rxsVNkdFohYdpsG
         +ktA1hGshyrN61DRC69Bluwi489OOVX+l7sdBi59r5yJPP/cZWEReRcYt8He4DhKQHWW
         PWn6Le7NJqJBd2HKAu1zZtNCOvTQKqoDRq8z5/mnL0FTG0H1/pQDNP9BIHCfuuNPRF+8
         R53e1LNeFNbXlQ4miDC0xfvTCafH96Ou/vLEek06OVhbz8TABRWLFZjFYZyfAaF29y81
         H+Zv6RvFT1z1pzV7zDLAD/wsLUG/ebncINn8BmzyY7+7rdax98mWvHAzF/LAq0Mk956J
         BHdA==
X-Gm-Message-State: APjAAAWEljuLow4qewT68Sxlhxu2fx1oFgUvrnZlYSIJqFQQeTKTzXDh
        zmvBNXI762uuURRRj22g2jxCAzUFjKoeh2uEHsU=
X-Google-Smtp-Source: APXvYqxKlpMQ16lyxb2rqAaNSnzwJFkCgIRzEOETgCupDo2A7FTyeUI/169Q2yk1CUan1rSY8NvwcN+6M9FzkqTuzEM=
X-Received: by 2002:a37:7086:: with SMTP id l128mr33235152qkc.433.1568454966877;
 Sat, 14 Sep 2019 02:56:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190913173821.GA5986@SARKAR> <20190913180103.GB5986@SARKAR>
In-Reply-To: <20190913180103.GB5986@SARKAR>
From:   Austin Kim <austindh.kim@gmail.com>
Date:   Sat, 14 Sep 2019 18:55:46 +0900
Message-ID: <CADLLry5W-1urBdYDPdYvcw5fwaiKa_G7R1PFPBtzFQ20o=Rn5A@mail.gmail.com>
Subject: Re: Problems during compiling in kernel modules
To:     Rohit Sarkar <rohitsarkar5398@gmail.com>
Cc:     linux-newbie@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,
Would you follow below steps to build kernel source?

1) Download latest linux kernel source tree:
git clone https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/lin=
ux-next.git


2) Generate kernel config(allyesconfig):
cd linux-next
make arch=3Dx86_64 allyesconfig

3) Build kernel Source as you mentioned:

2019=EB=85=84 9=EC=9B=94 14=EC=9D=BC (=ED=86=A0) =EC=98=A4=EC=A0=84 4:26, R=
ohit Sarkar <rohitsarkar5398@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=
=B1:
>
> On Fri, Sep 13, 2019 at 11:08:21PM +0530, Rohit Sarkar wrote:
> > Hi,
> > I was trying to compile a particular folder in my kernel tree.
> >
> > AFAIK the way to do this is:
> > `make drivers/staging/iio/` from the kernel base directory.
> >
> > This gives me the following output:
> > `
> >   CALL    scripts/checksyscalls.sh
> >   CALL    scripts/atomic/check-atomics.sh
> >   DESCEND  objtool
> > `
> >
> > No object files are generated.
> > I feel like I am missing something.
> >
> > Thanks,
> > Rohit
>
> I ran `make clean` in the `drivers/iio/accel` directory which removed
> all object files in the first place. However running make after that
> doesnt seem to compile the modules.
>
> Thanks,
> Rohit
