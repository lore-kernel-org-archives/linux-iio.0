Return-Path: <SRS0=fsUv=OM=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DB3FC04EBF
	for <linux-iio@archiver.kernel.org>; Mon,  3 Dec 2018 20:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D92772145D
	for <linux-iio@archiver.kernel.org>; Mon,  3 Dec 2018 20:06:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=interia.pl header.i=@interia.pl header.b="EL9eNwMS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D92772145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=poczta.fm
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-iio-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725936AbeLCUGQ (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 3 Dec 2018 15:06:16 -0500
Received: from smtpo.poczta.interia.pl ([217.74.65.155]:43927 "EHLO
        smtpo.poczta.interia.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbeLCUGQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 3 Dec 2018 15:06:16 -0500
X-Interia-R: Interia
X-Interia-R-IP: 188.121.17.172
X-Interia-R-Helo: <t480s.localdomain>
Received: from t480s.localdomain (unknown [188.121.17.172])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by www.poczta.fm (INTERIA.PL) with ESMTPSA;
        Mon,  3 Dec 2018 21:06:03 +0100 (CET)
Date:   Mon, 3 Dec 2018 21:06:41 +0100
From:   Slawomir Stepien <sst@poczta.fm>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH 1/3] staging: iio: adc: ad7280a: split
 ad7280_channel_init() to more functions
Message-ID: <20181203200641.GA1330@t480s.localdomain>
References: <20181202115830.20363-1-sst@poczta.fm>
 <20181202115830.20363-2-sst@poczta.fm>
 <20181202154512.5ed31f1f@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181202154512.5ed31f1f@archlinux>
User-Agent: Mutt/1.11.0 (2018-11-25)
X-Interia-Antivirus: OK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=interia.pl;
        s=biztos; t=1543867566;
        bh=KK21v8tq/ktF0MjQxUfk1VjChxfSgTfwws4TyhwGXvM=;
        h=X-Interia-R:X-Interia-R-IP:X-Interia-R-Helo:Date:From:To:Cc:
         Subject:Message-ID:References:MIME-Version:Content-Type:
         Content-Disposition:In-Reply-To:User-Agent:X-Interia-Antivirus;
        b=EL9eNwMS+irYLDYUDJDUmYv5e0N1Oak38CZ/nm1LbJmoWB6JlDH96Nb00HsvuHYf4
         iDxAkfxdDBLWLNodW2JFmQoBCqc9IQKg4SiWiqvwf+xKfxUFdbyIWfWbDPgkBxxlch
         wluaXQ3WhJDmaNfq6Q/0X0clHEyCnfSjZSEdnjRQ=
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On gru 02, 2018 15:45, Jonathan Cameron wrote:
> On Sun,  2 Dec 2018 12:58:28 +0100
> Slawomir Stepien <sst@poczta.fm> wrote:
> 
> > The ad7280_channel_init function has been split into more specific
> > functions to increase the code readability.
> > 
> > Signed-off-by: Slawomir Stepien <sst@poczta.fm>
> Hi Slawomir,

Hi

> A few comments inline.  I agree with the basic idea, but suggest
> a slight different balance in where things are handled.

Thank you for the review. I agree with the comments, but please see one remark
below.

> > ---
> >  drivers/staging/iio/adc/ad7280a.c | 119 +++++++++++++++++++-----------
> >  1 file changed, 77 insertions(+), 42 deletions(-)
> > 
> > diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
> > index 7a0ba26f9fd9..a6b1bdd9f372 100644
> > --- a/drivers/staging/iio/adc/ad7280a.c
> > +++ b/drivers/staging/iio/adc/ad7280a.c
> > @@ -496,6 +496,75 @@ static const struct attribute_group ad7280_attrs_group = {
> >  	.attrs = ad7280_attributes,
> >  };
> >  
> > +static void ad7280_voltage_channel_init(struct ad7280_state *st, int cnt,
> > +					int dev, int ch)
> > +{
> > +	struct iio_chan_spec *chan = &st->channels[cnt];
> 
> Pass the chan spec in here instead of the _state structure.
> It will give cleaner code and better visibility on the scope of
> this function where it is called.
> 
> > +
> > +	chan->type = IIO_VOLTAGE;
> > +	chan->differential = 1;
> > +	chan->channel = (dev * 6) + ch;
> 
> This offset does seem more than a little random buried away in this function.
> I would pass it in explicitly as a parameter so that the we have all the
> channel number manipulations visible in one place.
> 
> > +	chan->channel2 = chan->channel + 1;
> > +}
> > +
> > +static void ad7280_temp_channel_init(struct ad7280_state *st, int cnt, int dev,
> > +				     int ch)
> > +{
> > +	struct iio_chan_spec *chan = &st->channels[cnt];
> > +
> > +	chan->type = IIO_TEMP;
> > +	chan->channel = (dev * 6) + ch - 6;
> This one is even more obscure when found in here. Pass it in as an additional parameter.
> > +}
> > +
> > +static void ad7280_common_fields_init(struct ad7280_state *st, int cnt, int dev,
> > +				      int ch)
> 
> It's not really the common fields given the voltage version is different.
> Perhaps there is a better name for this function?

I don't understand. The fields of the chan in this function are set to the same
values for volt and temp channels (this function is called at the end of the
for loop regardless of the AD type of the channel). I do not see how the voltage
version is different.

> > +{
> > +	struct iio_chan_spec *chan = &st->channels[cnt];
> > +
> > +	chan->indexed = 1;
> > +	chan->info_mask_separate = BIT(IIO_CHAN_INFO_RAW);
> > +	chan->info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE);
> > +	chan->address = ad7280a_devaddr(dev) << 8 | ch;
> > +	chan->scan_index = cnt;
> > +	chan->scan_type.sign = 'u';
> > +	chan->scan_type.realbits = 12;
> > +	chan->scan_type.storagebits = 32;
> > +	chan->scan_type.shift = 0;
> 
> I doubt there is any need to set shift and 0 is the obvious default
> so no 'documentation' benefit in doing it here.
> 
> > +}
> > +
> > +static void ad7280_all_voltage_channel_init(struct ad7280_state *st, int cnt,
> > +					    int dev)
> Total voltage perhaps rather than 'all'? 
> > +{
> > +	struct iio_chan_spec *chan = &st->channels[cnt];
> > +
> > +	chan->type = IIO_VOLTAGE;
> > +	chan->differential = 1;
> > +	chan->channel = 0;
> > +	chan->channel2 = dev * 6;
> > +	chan->address = AD7280A_ALL_CELLS;
> > +	chan->indexed = 1;
> > +	chan->info_mask_separate = BIT(IIO_CHAN_INFO_RAW);
> > +	chan->info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE);
> > +	chan->scan_index = cnt;
> > +	chan->scan_type.sign = 'u';
> > +	chan->scan_type.realbits = 32;
> > +	chan->scan_type.storagebits = 32;
> > +	chan->scan_type.shift = 0;
> > +}
> > +
> > +static void ad7280_timestamp_channel_init(struct ad7280_state *st, int cnt)
> > +{
> > +	struct iio_chan_spec *chan = &st->channels[cnt];
> > +
> > +	chan->type = IIO_TIMESTAMP;
> > +	chan->channel = -1;
> > +	chan->scan_index = cnt;
> > +	chan->scan_type.sign = 's';
> > +	chan->scan_type.realbits = 64;
> > +	chan->scan_type.storagebits = 64;
> > +	chan->scan_type.shift = 0;
> > +}
> > +
> >  static int ad7280_channel_init(struct ad7280_state *st)
> >  {
> >  	int dev, ch, cnt;
> > @@ -508,51 +577,17 @@ static int ad7280_channel_init(struct ad7280_state *st)
> >  	for (dev = 0, cnt = 0; dev <= st->slave_num; dev++)
> >  		for (ch = AD7280A_CELL_VOLTAGE_1; ch <= AD7280A_AUX_ADC_6;
> >  			ch++, cnt++) {
> > -			if (ch < AD7280A_AUX_ADC_1) {
> > -				st->channels[cnt].type = IIO_VOLTAGE;
> > -				st->channels[cnt].differential = 1;
> > -				st->channels[cnt].channel = (dev * 6) + ch;
> > -				st->channels[cnt].channel2 =
> > -					st->channels[cnt].channel + 1;
> > -			} else {
> > -				st->channels[cnt].type = IIO_TEMP;
> > -				st->channels[cnt].channel = (dev * 6) + ch - 6;
> > -			}
> > -			st->channels[cnt].indexed = 1;
> > -			st->channels[cnt].info_mask_separate =
> > -				BIT(IIO_CHAN_INFO_RAW);
> > -			st->channels[cnt].info_mask_shared_by_type =
> > -				BIT(IIO_CHAN_INFO_SCALE);
> > -			st->channels[cnt].address =
> > -				ad7280a_devaddr(dev) << 8 | ch;
> > -			st->channels[cnt].scan_index = cnt;
> > -			st->channels[cnt].scan_type.sign = 'u';
> > -			st->channels[cnt].scan_type.realbits = 12;
> > -			st->channels[cnt].scan_type.storagebits = 32;
> > -			st->channels[cnt].scan_type.shift = 0;
> > +			if (ch < AD7280A_AUX_ADC_1)
> > +				ad7280_voltage_channel_init(st, cnt, dev, ch);
> > +			else
> > +				ad7280_temp_channel_init(st, cnt, dev, ch);
> > +
> > +			ad7280_common_fields_init(st, cnt, dev, ch);
> >  		}
> >  
> > -	st->channels[cnt].type = IIO_VOLTAGE;
> > -	st->channels[cnt].differential = 1;
> > -	st->channels[cnt].channel = 0;
> > -	st->channels[cnt].channel2 = dev * 6;
> > -	st->channels[cnt].address = AD7280A_ALL_CELLS;
> > -	st->channels[cnt].indexed = 1;
> > -	st->channels[cnt].info_mask_separate = BIT(IIO_CHAN_INFO_RAW);
> > -	st->channels[cnt].info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE);
> > -	st->channels[cnt].scan_index = cnt;
> > -	st->channels[cnt].scan_type.sign = 'u';
> > -	st->channels[cnt].scan_type.realbits = 32;
> > -	st->channels[cnt].scan_type.storagebits = 32;
> > -	st->channels[cnt].scan_type.shift = 0;
> > +	ad7280_all_voltage_channel_init(st, cnt, dev);
> >  	cnt++;
> > -	st->channels[cnt].type = IIO_TIMESTAMP;
> > -	st->channels[cnt].channel = -1;
> > -	st->channels[cnt].scan_index = cnt;
> > -	st->channels[cnt].scan_type.sign = 's';
> > -	st->channels[cnt].scan_type.realbits = 64;
> > -	st->channels[cnt].scan_type.storagebits = 64;
> > -	st->channels[cnt].scan_type.shift = 0;
> > +	ad7280_timestamp_channel_init(st, cnt);
> >  
> >  	return cnt + 1;
> >  }
> 

-- 
Slawomir Stepien
