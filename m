Return-Path: <SRS0=YVHc=3I=gmail.com=singhalsimran0@kernel.org>
MIME-Version: 1.0
In-Reply-To: <1490986224.27353.20.camel@perches.com>
References: <1490978804-25549-1-git-send-email-singhalsimran0@gmail.com>
 <1490978804-25549-2-git-send-email-singhalsimran0@gmail.com>
 <1490985230.27353.18.camel@perches.com> <CALrZqyNXv53FeHNMpJ-i8Lkize-TTMR7LB6ssa0H4gS-L9JAeA@mail.gmail.com>
 <1490986224.27353.20.camel@perches.com>
From: SIMRAN SINGHAL <singhalsimran0@gmail.com>
Date: Sat, 1 Apr 2017 00:38:54 +0530
Message-ID: <CALrZqyP7QVz-m+AGTwcuBR-xYxv1GagvZBMhPxHO15tnyPW8HA@mail.gmail.com>
Subject: Re: [PATCH 1/3] iio: health: afe440x: Remove code in comments
To: Joe Perches <joe@perches.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

Please ignore this Patch. This Patch is wrong.

On Sat, Apr 1, 2017 at 12:20 AM, Joe Perches <joe@perches.com> wrote:
> On Sat, 2017-04-01 at 00:13 +0530, SIMRAN SINGHAL wrote:
>> On Sat, Apr 1, 2017 at 12:03 AM, Joe Perches <joe@perches.com> wrote:
>> > On Fri, 2017-03-31 at 22:16 +0530, simran singhal wrote:
>> > > Commenting out code is a bad idea.
>> > > As comments are for explaining what code is about.
>> >
>> > patch doesn't match commit message.
>>
>> In commit message I am clearly saying commenting out the code is a bad Idea.
>> As comments are for explaining what code is about.
>> And that's what I am doing in the patch deleting the commented codes.
>>
>> My subject also says "Remove code in comments"
>>
>> Than what is not matching?
>
> Read your own patch.
>
> You are removing #defines not comments.
>
> If the whole thing is in comments, then
> the #defines immediately above what you
> are removing should also be deleted.
>
>> >
>> > > Signed-off-by: simran singhal <singhalsimran0@gmail.com>
>> > > ---
>> > >  drivers/iio/health/afe440x.h | 58 --------------------------------------------
>> > >  1 file changed, 58 deletions(-)
>> > >
>> > > diff --git a/drivers/iio/health/afe440x.h b/drivers/iio/health/afe440x.h
>> > > index 1a0f247..71e2f0e 100644
>> > > --- a/drivers/iio/health/afe440x.h
>> > > +++ b/drivers/iio/health/afe440x.h
>> > > @@ -88,56 +88,11 @@
>> > >  #define AFE440X_CONTROL0_WRITE               0x0
>> > >  #define AFE440X_CONTROL0_READ                0x1
>> > >
>> > > -#define AFE440X_INTENSITY_CHAN(_index, _mask)                        \
>> > > -     {                                                       \
>> > > -             .type = IIO_INTENSITY,                          \
>> > > -             .channel = _index,                              \
>> > > -             .address = _index,                              \
>> > > -             .scan_index = _index,                           \
>> > > -             .scan_type = {                                  \
>> > > -                             .sign = 's',                    \
>> > > -                             .realbits = 24,                 \
>> > > -                             .storagebits = 32,              \
>> > > -                             .endianness = IIO_CPU,          \
>> > > -             },                                              \
>> > > -             .info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |  \
>> > > -                     _mask,                                  \
>> > > -             .indexed = true,                                \
>> > > -     }
>> > > -
>> > > -#define AFE440X_CURRENT_CHAN(_index)                         \
>> > > -     {                                                       \
>> > > -             .type = IIO_CURRENT,                            \
>> > > -             .channel = _index,                              \
>> > > -             .address = _index,                              \
>> > > -             .scan_index = -1,                               \
>> > > -             .info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |  \
>> > > -                     BIT(IIO_CHAN_INFO_SCALE),               \
>> > > -             .indexed = true,                                \
>> > > -             .output = true,                                 \
>> > > -     }
>> > > -
>> > >  struct afe440x_val_table {
>> > >       int integer;
>> > >       int fract;
>> > >  };
>> > >
>> > > -#define AFE440X_TABLE_ATTR(_name, _table)                            \
>> > > -static ssize_t _name ## _show(struct device *dev,                    \
>> > > -                           struct device_attribute *attr, char *buf) \
>> > > -{                                                                    \
>> > > -     ssize_t len = 0;                                                \
>> > > -     int i;                                                          \
>> > > -                                                                     \
>> > > -     for (i = 0; i < ARRAY_SIZE(_table); i++)                        \
>> > > -             len += scnprintf(buf + len, PAGE_SIZE - len, "%d.%06u ", \
>> > > -                              _table[i].integer,                     \
>> > > -                              _table[i].fract);                      \
>> > > -                                                                     \
>> > > -     buf[len - 1] = '\n';                                            \
>> > > -                                                                     \
>> > > -     return len;                                                     \
>> > > -}                                                                    \
>> > >  static DEVICE_ATTR_RO(_name)
>> > >
>> > >  struct afe440x_attr {
>> > > @@ -147,17 +102,4 @@ struct afe440x_attr {
>> > >       unsigned int table_size;
>> > >  };
>> > >
>> > > -#define to_afe440x_attr(_dev_attr)                           \
>> > > -     container_of(_dev_attr, struct afe440x_attr, dev_attr)
>> > > -
>> > > -#define AFE440X_ATTR(_name, _field, _table)                  \
>> > > -     struct afe440x_attr afe440x_attr_##_name = {            \
>> > > -             .dev_attr = __ATTR(_name, (S_IRUGO | S_IWUSR),  \
>> > > -                                afe440x_show_register,       \
>> > > -                                afe440x_store_register),     \
>> > > -             .field = _field,                                \
>> > > -             .val_table = _table,                            \
>> > > -             .table_size = ARRAY_SIZE(_table),               \
>> > > -     }
>> > > -
>> > >  #endif /* _AFE440X_H */
