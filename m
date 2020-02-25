Return-Path: <SRS0=5MmI=4N=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA45FC35E01
	for <linux-iio@archiver.kernel.org>; Tue, 25 Feb 2020 17:11:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D9DA20CC7
	for <linux-iio@archiver.kernel.org>; Tue, 25 Feb 2020 17:11:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H8HqWvZ0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730788AbgBYRL4 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 25 Feb 2020 12:11:56 -0500
Received: from mail-pg1-f182.google.com ([209.85.215.182]:43073 "EHLO
        mail-pg1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730738AbgBYRL4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 25 Feb 2020 12:11:56 -0500
Received: by mail-pg1-f182.google.com with SMTP id u12so7168545pgb.10
        for <linux-iio@vger.kernel.org>; Tue, 25 Feb 2020 09:11:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=/JIqNTD58+4uui0yT0NCtGSYIEj70iWMAMmdLmiPtDk=;
        b=H8HqWvZ0TgFOeZEuPhrXKzEsqI4myYULCVXGDQXrM3h5ynd53zDLT50Uogzfoak1Cl
         k1cc1awCmqp6CXqhIRJTrybXIKG5C6mkN/uG94+iQKJ/csgQunwNa6Sf2nFXrR5T7ldQ
         XeIPbxDjzZpd9BTE7gRpYATrk/59bn+fsdHtukWntp5/3HnKyBNZwrmZLYEO6+yMjmD0
         bJ9qT7s88xykEyW3r9HZaBkgmZ+PpkrLTohG7OIsBKkDNzWiPfTtmVrk7GNho/zNZnJD
         Dfh4PcIiAf3zMFiguV6orc20clJ+HPTydYH7cMZVgMpyJp+uZlrIsc4vAe1UQqayqqnM
         HWyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=/JIqNTD58+4uui0yT0NCtGSYIEj70iWMAMmdLmiPtDk=;
        b=PF8yWBRUxsG7bW+r4mjasVo1MgPvq7d9Zqr2ZZ4zqa15X03zM1RKgd8bqF0atAz2Tl
         53+fcT5XHIm1yXajQm4UbJBTyqVNi5EoSk/O6SoJ4vAiWO8RNvF5rPdTonbn/X5UY/Aw
         7UQhlVIPoAdOB9r2QdZWfXIIdkJrAYlzb2yZNTQQjW/8c8wHDAQVZIX5Ewsk7KGhULC0
         m1gK8lJDG9oTSTHDHxX/G2UxUBmF/NTO5cm+rl1Qm0LawyZrPt9IkBohnRcktDpywGeR
         0tUSGxpm5mNffIX/kIWUKLKc5VTaU23Fko30dB/jVlNCLCdrSzYRfvL/Gyrjo7ZmyGnH
         KhJQ==
X-Gm-Message-State: APjAAAXoY/cjabec/jsejBzsXMmDHi+YGmdhTdUxDARdMwUdJAZ/TBpe
        GA9hkBYj+xmd9jYKyt+mtgDKxhDYqks=
X-Google-Smtp-Source: APXvYqzvFV9qNSHVChzmBhRIgvB9Rya6Hvi0yeT8ybWwdLe3wI1fLxT+9BucXOKwJe3La3l0oKEIVA==
X-Received: by 2002:a63:5a11:: with SMTP id o17mr59696872pgb.60.1582650715104;
        Tue, 25 Feb 2020 09:11:55 -0800 (PST)
Received: from SARKAR ([49.207.57.206])
        by smtp.gmail.com with ESMTPSA id j125sm17871572pfg.160.2020.02.25.09.11.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 09:11:54 -0800 (PST)
Date:   Tue, 25 Feb 2020 22:41:50 +0530
From:   Rohit Sarkar <rohitsarkar5398@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     rohitsarkar5398@gmail.com
Subject: query about locking in IIO
Message-ID: <20200225171150.GD24663@SARKAR>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,
Could someone explain why using indio_dev->mlock directly is a bad idea?
Further examples of cases where it cannot be replaced will be helpful

Thanks,
Rohit

