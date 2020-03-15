Return-Path: <SRS0=tzPa=5A=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9C22C10DCE
	for <linux-iio@archiver.kernel.org>; Sun, 15 Mar 2020 15:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70B8820637
	for <linux-iio@archiver.kernel.org>; Sun, 15 Mar 2020 15:30:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cv1fXs3Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728681AbgCOPaT (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 15 Mar 2020 11:30:19 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:39951 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726501AbgCOPaT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 15 Mar 2020 11:30:19 -0400
Received: by mail-il1-f196.google.com with SMTP id g6so13970701ilc.7;
        Sun, 15 Mar 2020 08:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B6vLi19pQG8Kndj6TkztWhdsEWBVAklN1V/SBYs+3jI=;
        b=cv1fXs3ZKHbkKEwbav0XD9dLAS63yPJcTS/5KHmgfH4r+KL0QwPqjKhDA4I4IiAXZu
         8AEUEWZuWHgfIM91tOb8X6k6U4LZ/ANkAT6wgpFydYaXXczPLIAdfvzdXCKDJDtj81++
         HR6Gy2UxdDlu7DJrz6Mp9YysUXyzH2yfycIepN4SdAtbRSDPZWxKE50MjjTCdA2jrfu7
         0iyhrn+QE8zIonJAhzMSqg960Iq0lQXWjrXvdmkDJp4Xf69IGWCmeBzWHLKyWbf8wfCI
         h3d6YbiF/jpCAy8JE+Yq8FwKg5DkXEkmMYjtaxYlyMNkf67RweBD87W5W/hCSCLnB/qZ
         V2eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B6vLi19pQG8Kndj6TkztWhdsEWBVAklN1V/SBYs+3jI=;
        b=l7afy1mmkCCrTn+MywHi3YWbo/RTpYArqC3hytMeiTOH8dL1BYISYuVPvP/dyTPRKY
         eAHTWxpBxKezWWdsyqJF9sgauim+zM9DzhLbegQ+7AornO8i04YoO0ZLnIdA8yGGlZ8i
         p3Z0SnQrHhQV7gW8+MOGWrTKZOlgL91JF93tYEKxWk08rZpNr1KWR0/FQC8ijLjag++x
         UgJSOI9QUKqmjAgPEOpB+WtCRCFZVYwBcMI39azZZa1MZ5jp6r5OHozFc8ZQ0v1R0n0C
         OdPDlBx9n19F+lYIl/bU8VBccRk/50vn+7rpgavXbtGq0hAw/DlN7kVp5wN/nRi+meQ7
         976Q==
X-Gm-Message-State: ANhLgQ02Qk5evM8wVI3blwxFiQLU54q5Zne9/Yo5H1Ork92P98TgVcyB
        I8geq6v2oGtF5bIgxWhe3Xoxhy/DYYV2qjpWj+Q+RQ==
X-Google-Smtp-Source: ADFU+vt/2lmifQgtCbARFOKl7Hjk8gUDJobidLOT+F/Ya4rtapCehoAxBiWSqmX/o8IPOHHm38F9SxN/YsXOoN9nukM=
X-Received: by 2002:a92:5bd7:: with SMTP id c84mr23906272ilg.26.1584286218683;
 Sun, 15 Mar 2020 08:30:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200313120057.GA17812@syed> <20200313165102.GA5024@icarus>
 <20200315120904.2475a9c1@archlinux> <20200315140512.GA3260@icarus>
 <20200315142916.25ffa24f@archlinux> <20200315143927.GA4087@icarus>
In-Reply-To: <20200315143927.GA4087@icarus>
From:   Syed Waris <syednwaris@gmail.com>
Date:   Sun, 15 Mar 2020 21:00:07 +0530
Message-ID: <CACG_h5pRVia_QstRjrJ9pBswnSY8pcUgYC5gTJH0fk-r=NYy7g@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] counter: 104-quad-8: Add lock guards - generic interface
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Thank you Jonathan and William for illuminating on this. I understand
the arguments put forward.

I will submit newer version of the patches soon.

Regards
Syed N. Waris
