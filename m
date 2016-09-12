Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lf0-f51.google.com ([209.85.215.51]:34902 "EHLO
        mail-lf0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754396AbcILHdU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 12 Sep 2016 03:33:20 -0400
Received: by mail-lf0-f51.google.com with SMTP id l131so80741719lfl.2
        for <linux-iio@vger.kernel.org>; Mon, 12 Sep 2016 00:33:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20160911162907.22449-1-hdegoede@redhat.com>
References: <20160911162907.22449-1-hdegoede@redhat.com>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Mon, 12 Sep 2016 10:33:18 +0300
Message-ID: <CAEnQRZBKg7oEi5QXqyxwtR=1mkk_ab7nwSQSAeFZRvBygnfbfg@mail.gmail.com>
Subject: Re: [PATCH] iio: accel: Add driver for the mCube MC3230 3-axis accelerometer
To: Hans de Goede <hdegoede@redhat.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, Sep 11, 2016 at 7:29 PM, Hans de Goede <hdegoede@redhat.com> wrote:
> Add an IIO driver for the mCube MC3230 3-axis accelerometer.

Hi Hans,

This looks good. Could you add a link to documentation in the commit message?
