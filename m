Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:46344 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbeGREZo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Jul 2018 00:25:44 -0400
Date: Tue, 17 Jul 2018 20:49:54 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: gregkh@linuxfoundation.org, jic23@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        fabrice.gasnier@st.com, benjamin.gaignard@st.com,
        robh+dt@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, mark.rutland@arm.com
Subject: Re: [PATCH v7 01/10] counter: Introduce the Generic Counter
 interface
Message-Id: <20180717204954.4b5e371603d0b40b2aaabbb8@linux-foundation.org>
In-Reply-To: <51b75b2b4495d4ad7ed173d91a726379bdae2353.1529607879.git.vilhelm.gray@gmail.com>
References: <cover.1529607879.git.vilhelm.gray@gmail.com>
        <51b75b2b4495d4ad7ed173d91a726379bdae2353.1529607879.git.vilhelm.gray@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 21 Jun 2018 17:07:08 -0400 William Breathitt Gray <vilhelm.gray@gmail.com> wrote:

> This patch introduces the Generic Counter interface for supporting
> counter devices.
> 

+EXPORT_SYMBOL(count_direction_str);
+EXPORT_SYMBOL(count_mode_str);
+EXPORT_SYMBOL(counter_signal_enum_read);
+EXPORT_SYMBOL(counter_signal_enum_write);
+EXPORT_SYMBOL(counter_signal_enum_available_read);
+EXPORT_SYMBOL(counter_count_enum_read);
+EXPORT_SYMBOL(counter_count_enum_write);
+EXPORT_SYMBOL(counter_count_enum_available_read);
+EXPORT_SYMBOL(counter_device_enum_read);
+EXPORT_SYMBOL(counter_device_enum_write);
+EXPORT_SYMBOL(counter_device_enum_available_read);
+EXPORT_SYMBOL(signal_read_value_set);
+EXPORT_SYMBOL(count_read_value_set);
+EXPORT_SYMBOL(count_write_value_get);
+EXPORT_SYMBOL(counter_register);
+EXPORT_SYMBOL(counter_unregister);
+EXPORT_SYMBOL(devm_counter_register);
+EXPORT_SYMBOL(devm_counter_unregister);

The naming is a bit chaotic.  Most of the symbols start with counter_,
which is good.  But a handful do not.

Also, symbols called signal_* make my head spin - Linux already has a
firmly ingrained notion of what a signal is, and this ain't it ;)
Although the kernel tends to use sig_ for signals-as-an-IPC-thing.

Also, many many drivers deal with signals-as-an-electrical-thing - is
it appropriate for this particular driver to take that namespace?

